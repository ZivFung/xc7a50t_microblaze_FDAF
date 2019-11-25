#ifndef _COMMON_H_
#define _COMMON_H_
#include "xgpio.h"
#include <xil_types.h>
#include "xparameters.h"
#include "Dma/AxiDma.h"
#include "FFT/Xfft.h"
#include "AF/AF.h"
#include "CDMA/AxiCdma.h"
#include "PL_MBDataEXC.h"
using namespace XilAxiDMA;
using namespace XFFT;

extern XilAxiDma *da_dma;
extern XilAxiDma *ad_dma0;
extern XilAxiDma *ad_dma1;
extern XilAxiDma *fft_dma;
extern XilAxiDma *coplex1_dma;
extern XilAxiDma *coplex2_dma;
extern XilAxiDma *conj1_dma;
extern XilAxiDma *conj2_dma;
extern XilAxiDma *UpdatePM_dma;
extern Xfft *fft;
extern XGpio GpioLed;
extern XGpio GpioKey;
extern XilAxiCDMA::XilAxiCdma *memoryCpy_dma;

inline void GpioSet(XGpio *gpio, unsigned int msk)
{
	u32 temp;
	temp = XGpio_ReadReg(gpio->BaseAddress, XGPIO_DATA_OFFSET);
	temp |= msk;
	XGpio_WriteReg(gpio->BaseAddress, XGPIO_DATA_OFFSET, temp);
}

inline void GpioClr(XGpio *gpio, unsigned int msk)
{
	u32 temp;
	temp = XGpio_ReadReg(gpio->BaseAddress, XGPIO_DATA_OFFSET);
	temp &= ~msk;
	XGpio_WriteReg(gpio->BaseAddress, XGPIO_DATA_OFFSET, temp);
}

void InitCommonResources();
void InitPeriphral();
void TimerTestStart();
u32 TimerTestStop();
u32 TimerTestGetValue();
int DmaDataTranfer(Cplx16<15> *DataBuf, u32 Length,int Direction);
#endif
