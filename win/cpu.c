#include <Windows.h>
#include <stdio.h>

int main()
{
  SYSTEM_INFO sysinfo;
  GetSystemInfo( &sysinfo );

  int numCPU = sysinfo.dwNumberOfProcessors;
  
  printf("%d\n", numCPU);
  
  return 0;
}

