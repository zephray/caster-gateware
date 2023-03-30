// Copyright Modos / Wenting Zhang 2023
//
// This source describes Open Hardware and is licensed under the CERN-OHL-P v2
//
// You may redistribute and modify this documentation and make products using
// it under the terms of the CERN-OHL-P v2 (https:/cern.ch/cern-ohl). This
// documentation is distributed WITHOUT ANY EXPRESS OR IMPLIED WARRANTY,
// INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A
// PARTICULAR PURPOSE. Please see the CERN-OHL-P v2 for applicable conditions
//
// bramdp.v
// Generic dual port RAM, could be replaced with device specific implementation.
`timescale 1ns / 1ps
`default_nettype none
module bramdp(
    input wire clka,
    input wire wea,
    input wire [11:0] addra,
    input wire [7:0] dina,
    output reg [7:0] douta,
    input wire clkb,
    input wire web,
    input wire [11:0] addrb,
    input wire [7:0] dinb,
    output reg [7:0] doutb
);

    reg [7:0] mem [0:4095];

    always @(posedge clka) begin
        if (wea)
            mem[addra] <= dina;
        else
            douta <= mem[addra];
    end

    always @(posedge clkb) begin
        if (web)
            mem[addrb] <= dinb;
        else
            doutb <= mem[addrb];
    end
    
    initial begin
        $readmemh("default_waveform.mem", mem);
    end

endmodule
