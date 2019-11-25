/*
 * Empty C++ Application

 */


#include "xparameters.h"
#include "common.h"
#include "platform.h"
#include "xil_printf.h"
#include "FFT/Xfft.h"
#include <stdio.h>
#include "FixedPoint/FixedPoint.h"
#include "AF/AF.h"
#include "sleep.h"
#include "periph/Timer.h"

using namespace AF;
using namespace XilTIMER;
//Xfft *fft;
FDAF *AdptiveFilter;

//s16  test[8] = {1,2,3,4,5,6,7,8};
//u32  out[8] = {0};
//s32 *TestPtr = test;
//s32 TestOut[8] = {0};
//s32 *TestOutPtr = TestOut;

extern volatile int ConjRxIoc;
extern volatile int ConjTxIoc;
extern volatile int ComplexRxIoc;
extern volatile int ComplexTxIoc;
extern volatile int DataRxIoc0;
extern volatile int DataRxIoc1;
extern volatile int FFTRxIoc;
extern volatile int DataTxIoc;
extern volatile int MemCpyDmaIoc;
template <int FW>
struct MulBuffer{

	s16 Mul1_Re,Mul1_Im, Mul2_Re,Mul2_Im;
};

static void ResetADSystem(){
	PL_MBDATAEXC_mWriteReg(XPAR_HIER_PERIPH_PL_MBDATAEXC_S00_AXI_BASEADDR, PL_MBDATAEXC_S00_AXI_SLV_REG6_OFFSET, 0);		//turn off the ad Sample
	ad_dma0->DmaReset();
	ad_dma1->DmaReset();
	PL_MBDATAEXC_mWriteReg(XPAR_HIER_PERIPH_PL_MBDATAEXC_S00_AXI_BASEADDR, PL_MBDATAEXC_S00_AXI_SLV_REG6_OFFSET, 1);		//turn on the ad Sample
}

int main()
{
    init_platform();
    InitPeriphral();
    AdptiveFilter = new FDAF(fft);
    int Status;
//	AdptiveFilter->SetupCdmaBdRingForPMUpdate(memoryCpy_dma);
	AdptiveFilter->WriteADData2DDR();
//	AdptiveFilter->TestDDR();
	AdptiveFilter->FilterAdjWeight_DDR_FirstFrame();
	for(int i = 0; i < DATA_FRAME_NUM-5; i++){
		AdptiveFilter->FilterAdjWeight_DDR(i+5);
	}

//    AdptiveFilter->SetupCdmaBdRingForWeightComplex(memoryCpy_dma);
	AdptiveFilter->WriteWeight2Buffer();
	ResetADSystem();
	AdptiveFilter->ReadADData0and1_oldDesire();
	AdptiveFilter->PutDAData_Error();
	while(1)
	{
//		TimerTestStart();
//		test = TimerTestGetValue();
//		xil_printf("start count %d \n",test);

//		AdptiveFilter->ApdateFilterTest();


//		AdptiveFilter->FilterAdjWeight();
		AdptiveFilter->FilterOut();
//		AdptiveFilter->FilterAdjWeightTest();
//		AdptiveFilter->FilterOutNormal();

//		test = TimerTestGetValue();
//		xil_printf("end1 count %d \n",test);
//		test = TimerTestStop();

	}
    cleanup_platform();
	return 0;
}
