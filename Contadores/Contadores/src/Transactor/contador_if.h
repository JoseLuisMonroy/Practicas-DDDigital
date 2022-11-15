#ifndef __CONTADOR_IF_H__
#define __CONTADOR_IF_H__

#include <systemc.h>
#include "contador_args.h"


class contador_task_if : virtual public sc_interface
{
};


class contador_port_if : public sc_module
{
	public:
		sc_out<sc_logic > CLK;
		sc_out<sc_logic > CLR;
		sc_out<sc_logic > SEL;
		sc_inout<sc_lv<3> > Q;
		sc_inout<sc_lv<3> > QN;

	contador_port_if(sc_module_name nm) : sc_module(nm),
			CLK("CLK"),
			CLR("CLR"),
			SEL("SEL"),
			Q("Q"),
			QN("QN")
	{}
};



#endif // __CONTADOR_IF_H__
