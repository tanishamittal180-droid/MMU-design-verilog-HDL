`timescale 1ns/1ps

module mmu_tb;

reg clk=0;
always #5 clk=~clk;

reg rst_n;
reg en;

reg translate_en;

reg [19:0] satp_base_ppn;
reg [7:0] csr_asid;

reg req_valid;
reg [31:0] req_va;
reg [1:0] req_acc;
reg req_priv;

wire rsp_valid;
wire [31:0] rsp_pa;

wire rsp_fault;
wire rsp_xfault;

wire mem_req;
wire [31:0] mem_addr;

wire mem_rdy=0;
wire [31:0] mem_rdata=0;
wire mem_err=0;

reg pass_seen=0;


mmu DUT(

.clk(clk),
.rst_n(rst_n),
.en(en),

.translate_en(translate_en),

.satp_base_ppn(satp_base_ppn),
.csr_asid(csr_asid),

.req_valid(req_valid),
.req_va(req_va),
.req_acc(req_acc),
.req_priv(req_priv),

.rsp_valid(rsp_valid),
.rsp_pa(rsp_pa),

.rsp_fault(rsp_fault),
.rsp_xfault(rsp_xfault),

.mem_req(mem_req),
.mem_addr(mem_addr),

.mem_rdy(mem_rdy),
.mem_rdata(mem_rdata),
.mem_err(mem_err)

);


always @(posedge clk)
begin

    if(rsp_valid)
    begin

        if(rsp_pa==32'hCAFECABE)
        begin

            pass_seen<=1;

        end

    end

end



initial begin

$dumpfile("mmu.vcd");
$dumpvars(0,mmu_tb);

rst_n=0;
en=1;

translate_en=1;

req_valid=0;

#20;

rst_n=1;

req_va=32'hCAFEBABE;
req_acc=2'b01;
req_priv=0;

#20;

req_valid=1;

#10;

req_valid=0;


#100;


if(pass_seen)

    $display("PASS");

else

    $display("FAIL");


$finish;

end

endmodule