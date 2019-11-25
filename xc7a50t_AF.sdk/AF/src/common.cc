#include "common.h"
#include <xil_io.h>
#include "stdio.h"
#include "periph/Timer.h"
#include "periph/Intc.h"
#include "xdebug.h"
#include "UpdatePM.h"
#include "AF/AF.h"

using namespace XilTIMER;
using namespace XilINTC;
using namespace AF;

#define TIMER0FREQ 50
#define TIMER1FREQ 40

XGpio GpioLed;
//XGpio GpioKey;
XilIntc *intc;
XilTimer *timer;

Xfft *fft;
XilAxiDma *ad_dma0;
XilAxiDma *ad_dma1;
XilAxiDma *da_dma;
XilAxiDma *fft_dma;
XilAxiDma *coplex1_dma;
XilAxiDma *coplex2_dma;
XilAxiDma *conj1_dma;
XilAxiDma *conj2_dma;
XilAxiDma *UpdatePM_dma;
XilAxiCDMA::XilAxiCdma *memoryCpy_dma;
	void InitCommonResources()
	{
		if(XGpio_Initialize(&GpioLed, XPAR_HIER_PERIPH_GPIO_LED_DEVICE_ID))
			printf("Initialize GpioLed fail!\n");

	}
	void InitPeriphral()
	{
		try{
		InitCommonResources();
		intc = new XilIntc(XPAR_INTC_0_DEVICE_ID,
				XIN_REAL_MODE
				);
		timer = new XilTimer(XPAR_TMRCTR_0_DEVICE_ID,
				XPAR_INTC_0_TMRCTR_0_VEC_ID,
				intc,
				TIMER0FREQ,
				XTC_INT_MODE_OPTION,
				TIMER1FREQ,
				XTC_INT_MODE_OPTION | XTC_AUTO_RELOAD_OPTION | XTC_DOWN_COUNT_OPTION
				);
		fft_dma = new XilAxiDma(
				XPAR_HIER_AF_FFT_DMA_DEVICE_ID,
				intc,
				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_FFT_DMA_S2MM_INTROUT_INTR,
				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_FFT_DMA_MM2S_INTROUT_INTR,
				1,
				1
		);

		UpdatePM_dma = new XilAxiDma(
				XPAR_HIER_AF_PM_DMA_DEVICE_ID,
				intc,
				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_PM_DMA_S2MM_INTROUT_INTR,
				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_PM_DMA_MM2S_INTROUT_INTR,
				1,
				1
		);

		fft = new Xfft(
				1,
				0,
				fft_dma
		);
		ad_dma0 = new XilAxiDma(
				XPAR_HIER_AF_AD_DMA0_DEVICE_ID,
				intc,
				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_AD_DMA0_S2MM_INTROUT_INTR,
				0,
				1,
				0
		);
		ad_dma1 = new XilAxiDma(
				XPAR_HIER_AF_AD_DMA1_DEVICE_ID,
				intc,
				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_AD_DMA1_S2MM_INTROUT_INTR,
				0,
				1,
				0
		);
//		PL_MBDATAEXC_mWriteReg(XPAR_HIER_PERIPH_PL_MBDATAEXC_S00_AXI_BASEADDR, PL_MBDATAEXC_S00_AXI_SLV_REG6_OFFSET, 1);		//reset the ad fifo

		da_dma = new XilAxiDma(
				XPAR_HIER_AF_DA_DMA_DEVICE_ID,
				intc,
				0,
				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_DA_DMA_MM2S_INTROUT_INTR,
				0,
				1
		);
		coplex1_dma = new XilAxiDma(
				XPAR_HIER_AF_DMA_COMPLEX_DEVICE_ID,
				intc,
				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_DMA_COMPLEX_S2MM_INTROUT_INTR,
				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_DMA_COMPLEX_MM2S_INTROUT_INTR,
				1,
				1
		);
//		coplex2_dma = new XilAxiDma(
//				XPAR_HIER_AF_DMA_COMPLEX2_DEVICE_ID,
//				intc,
//				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_DMA_COMPLEX2_S2MM_INTROUT_INTR,
//				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_DMA_COMPLEX2_MM2S_INTROUT_INTR,
//				1,
//				1
//		);
		conj1_dma = new XilAxiDma(
				XPAR_HIER_AF_DMA_CONJ_DEVICE_ID,
				intc,
				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_DMA_CONJ_S2MM_INTROUT_INTR,
				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_DMA_CONJ_MM2S_INTROUT_INTR,
				1,
				1
		);
//		conj2_dma = new XilAxiDma(
//				XPAR_HIER_AF_DMA_CONJ2_DEVICE_ID,
//				intc,
//				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_DMA_CONJ2_S2MM_INTROUT_INTR,
//				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_DMA_CONJ2_MM2S_INTROUT_INTR,
//				1,
//				1
//		);
		UPDATEPM_mWriteReg(XPAR_HIER_AF_UPDATEPM_S00_AXI_BASEADDR, UPDATEPM_S00_AXI_SLV_REG0_OFFSET, PM_LANGMUDA-4);	//set up the updatePM IP
		memoryCpy_dma = new XilAxiCDMA::XilAxiCdma(
				XPAR_HIER_AF_CDMA_MEMCPY_DEVICE_ID,
				intc,
				1024,
				XPAR_HIER_PERIPH_MICROBLAZE_0_AXI_INTC_HIER_AF_CDMA_MEMCPY_CDMA_INTROUT_INTR,
				1
		);

	}
	catch(const char *str){
		xil_printf("Exception: %s", str);}
	}
	void TimerTestStart()
	{
		timer->Timer_Reset(0);
		timer->Timer_Start(0);
	}
	u32 TimerTestGetValue()
	{
		return timer->ReadTimer_Value(0);
	}
	u32 TimerTestStop()
	{
		timer->Timer_Stop(0);

		return timer->ReadTimer_Value(0);

	}

	int DmaDataTranfer(Cplx16<15> *DataBuf, u32 Length,int Direction)
	{
		int Status;
		u32 bytelen = sizeof(Cplx16<15>) * Length;
		switch(Direction)
		{
		case XAXIDMA_DMA_TO_DEVICE:
		Xil_DCacheFlushRange((u32)DataBuf, bytelen);
	#ifdef __aarch64__
		Xil_DCacheFlushRange((u32)DataBuf, bytelen);
	#endif
		return da_dma->DmaSimpleTransfer((u32)DataBuf,bytelen,Direction);break;
		case XAXIDMA_DEVICE_TO_DMA:
	#ifdef __aarch64__
			Xil_DCacheInvalidateRange((u32)DataBuf, bytelen);
	#endif
		do{
		Status = ad_dma0->DmaSimpleTransfer((u32)DataBuf,bytelen,Direction);
		}
		while(Status != XST_SUCCESS);
		Xil_DCacheFlushRange((u32)DataBuf, bytelen);

		return Status;
	break;
		}

	}

