`timescale 1ns/1ps

module perm_check
(
    input priv,

    input acc_load,
    input acc_store,
    input acc_ifetch,

    input pV,
    input pR,
    input pW,
    input pX,
    input pU,

    output allow,
    output pfault,
    output xfault
);

wire user_ok;

wire read_ok;
wire write_ok;
wire exec_ok;

assign user_ok =
(~priv) ? pU : 1'b1;


assign read_ok =
acc_load ? (pR & user_ok) : 1'b1;


assign write_ok =
acc_store ? (pW & user_ok) : 1'b1;


assign exec_ok =
acc_ifetch ? (pX & user_ok) : 1'b1;


assign allow =
pV &
read_ok &
write_ok &
exec_ok;


assign pfault =
pV &
(
(acc_load & ~pR) |
(acc_store & ~pW)
);


assign xfault =
pV &
(
acc_ifetch &
~pX
);

endmodule