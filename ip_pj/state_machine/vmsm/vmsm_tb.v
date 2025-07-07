// IP: 自動販売機ステートマシンのテストベンチ
// Ver: 0.1 (2025/7/7)
// Copyright (c) 2025 Chimipupu(https://github.com/Chimipupu) All Rights Reserved.

`timescale 1ns/1ps

module vmsm_tb;

    reg clk, reset_n;
    reg coin_inserted, product_selected, dispense_complete, change_returned;

    // DUTインスタンス
    vmsm uut (
        .clk(clk),
        .reset_n(reset_n)
    );

    // クロック生成
    initial clk = 0;
    always #5 clk = ~clk;

    // VCD波形ファイル出力
    initial begin
        $dumpfile("vmsm_tb.vcd");
        $dumpvars(0, vmsm_tb);
    end

    // シミュレーションシナリオ
    initial begin
        $display("===自動販売機ステートマシン テストベンチ===");

        // リセット解除
        reset_n = 0;
        #12;
        reset_n = 1;
        for(uut.reg_state = 0; uut.reg_state > 2'b11; uut.reg_state++) begin
            #20;
        end

        #30;
        $display("===終了===");
        $finish;
    end

endmodule