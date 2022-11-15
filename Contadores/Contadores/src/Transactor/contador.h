#ifndef __CONTADOR_H__
#define __CONTADOR_H__

#include <systemc.h>
#include "contador_if.h"


class contador : public contador_port_if,
		public contador_task_if
{
public:
		contador(sc_module_name nm) : contador_port_if(nm) {};

};

#endif // __CONTADOR_H__
