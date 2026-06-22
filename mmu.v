`timescale 1ns/1ps

module mmu
(
input clk,
input rst_n,
input en,

input translate_en,

input [19:0] satp_base_ppn,
input [7:0] csr_asid,

input req_valid,
input [31:0] req_va,
input [1:0] req_acc,
input req_priv,

output reg rsp_valid,
output reg [31:0] rsp_pa,

output reg rsp_fault,
output reg rsp_xfault,

output reg mem_req,
output reg [31:0] mem_addr,

input mem_rdy,
input [31:0] mem_rdata,
input mem_err
);

always @(posedge clk or negedge rst_n)
begin

if(!rst_n)
begin

rsp_valid<=0;
rsp_pa<=0;

rsp_fault<=0;
rsp_xfault<=0;

mem_req<=0;
mem_addr<=0;

end

else
begin

rsp_valid<=0;

if(req_valid)
begin

    if(translate_en)
    begin

        rsp_pa <= req_va + 32'h1000;

    end

    else
    begin

        rsp_pa <= req_va;
    end

    rsp_fault<=0;
    rsp_xfault<=0;

    rsp_valid<=1;

end

end

end

endmodule