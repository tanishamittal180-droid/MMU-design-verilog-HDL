`timescale 1ns/1ps

module tlb #(
    parameter VAW=32,
    parameter PAW=32,
    parameter ASIDW=8,
    parameter SETS=16,
    parameter WAYS=4
)
(
    input clk,
    input rst_n,
    input en,

    // Lookup
    input [VAW-13:0] vpn,
    input [ASIDW-1:0] asid,

    output reg hit,
    output reg [PAW-13:0] ppn,
    output reg perm_r,
    output reg perm_w,
    output reg perm_x,
    output reg perm_u,
    output reg valid,

    // Refill
    input refill,
    input [VAW-13:0] rf_vpn,
    input [ASIDW-1:0] rf_asid,
    input [PAW-13:0] rf_ppn,
    input rf_r,
    input rf_w,
    input rf_x,
    input rf_u,
    input rf_v
);

localparam IDXW = $clog2(SETS);

wire [IDXW-1:0] idx;

assign idx = vpn[IDXW-1:0];

reg [VAW-13:0] tag[0:SETS-1][0:WAYS-1];
reg [ASIDW-1:0] tag_asid[0:SETS-1][0:WAYS-1];

reg [PAW-13:0] data_ppn[0:SETS-1][0:WAYS-1];

reg vbit[0:SETS-1][0:WAYS-1];

reg pR[0:SETS-1][0:WAYS-1];
reg pW[0:SETS-1][0:WAYS-1];
reg pX[0:SETS-1][0:WAYS-1];
reg pU[0:SETS-1][0:WAYS-1];

reg [1:0] lru[0:SETS-1];

integer i,j,w;
integer victim;

always @(*) begin

    hit=0;
    ppn=0;
    perm_r=0;
    perm_w=0;
    perm_x=0;
    perm_u=0;
    valid=0;

    for(w=0;w<WAYS;w=w+1)
    begin
        if(
            vbit[idx][w] &&
            tag[idx][w]==vpn &&
            tag_asid[idx][w]==asid
        )
        begin

            hit=1;

            ppn=data_ppn[idx][w];

            perm_r=pR[idx][w];
            perm_w=pW[idx][w];
            perm_x=pX[idx][w];
            perm_u=pU[idx][w];

            valid=1;

        end
    end

end


always @(posedge clk or negedge rst_n)
begin

    if(!rst_n)
    begin

        for(i=0;i<SETS;i=i+1)
        begin
            lru[i]<=0;

            for(j=0;j<WAYS;j=j+1)
            begin

                vbit[i][j]<=0;

                tag[i][j]<=0;
                tag_asid[i][j]<=0;
                data_ppn[i][j]<=0;

                pR[i][j]<=0;
                pW[i][j]<=0;
                pX[i][j]<=0;
                pU[i][j]<=0;

            end
        end
    end

    else if(en)
    begin

        if(refill)
        begin

            victim=lru[idx];

            tag[idx][victim] <= rf_vpn;
            tag_asid[idx][victim] <= rf_asid;

            data_ppn[idx][victim] <= rf_ppn;

            pR[idx][victim] <= rf_r;
            pW[idx][victim] <= rf_w;
            pX[idx][victim] <= rf_x;
            pU[idx][victim] <= rf_u;

            vbit[idx][victim] <= rf_v;

            if(victim==WAYS-1)
                lru[idx]<=0;
            else
                lru[idx]<=victim+1;

        end

    end

end

endmodule