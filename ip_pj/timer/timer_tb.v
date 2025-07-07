// IP: タイマー モジュール テストベンチ
// Ver: 0.1 (2025/7/7)
// Copyright (c) 2025 Chimipupu(https://github.com/Chimipupu) All Rights Reserved.

module timer_tb;

reg clk;
reg rst;
reg [4:0] en;
reg [4:0] oneshot;
wire [31:0] count0, count1, count2, count3;
wire [63:0] count4;
wire irq0, irq1, irq2, irq3, irq4;

// インスタンス生成

// 32bitタイマ4本
timer #(32) timer0 (.clk(clk), .rst(rst), .en(en[0]), .oneshot(oneshot[0]), .compare_val(32'd10), .count(count0), .irq(irq0));
timer #(32) timer1 (.clk(clk), .rst(rst), .en(en[1]), .oneshot(oneshot[1]), .compare_val(32'd20), .count(count1), .irq(irq1));
timer #(32) timer2 (.clk(clk), .rst(rst), .en(en[2]), .oneshot(oneshot[2]), .compare_val(32'd30), .count(count2), .irq(irq2));
timer #(32) timer3 (.clk(clk), .rst(rst), .en(en[3]), .oneshot(oneshot[3]), .compare_val(32'd40), .count(count3), .irq(irq3));

// 64bitタイマ1本
timer #(64) timer4 (.clk(clk), .rst(rst), .en(en[4]), .oneshot(oneshot[4]), .compare_val(64'd100), .count(count4), .irq(irq4));

// クロック生成
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// テストシーケンス
initial begin
    $dumpfile("timer_tb.vcd");
    $dumpvars(0, timer_tb);

    rst = 1; en = 5'b00000; oneshot = 5'b00000;
    #20;
    rst = 0;

    en = 5'b11111;
    oneshot = 5'b01010;  // timer1とtimer3はワンショット、他はインターバル
    #500;

    en = 5'b00000;
    #50;

    $finish;
end

endmodule