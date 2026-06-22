`timescale 1ns/1ps

module mem_bram
#(
parameter PAW=32,
parameter DEPTH=4096
)
(
input clk,

input req,
input [PAW-1:0] addr,

output reg rdy,
output reg [31:0] rdata,
output reg err
);

reg [31:0] mem [0:DEPTH-1];

integer i;

initial
begin

for(i=0;i<DEPTH;i=i+1)
begin
    mem[i]=0;
end

end


always @(posedge clk)
begin

rdy<=0;
err<=0;

if(req)
begin

    rdata<=mem[addr[13:2]];

    rdy<=1;

end

end

endmodule