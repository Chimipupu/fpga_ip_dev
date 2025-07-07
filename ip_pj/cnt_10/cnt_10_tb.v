// IP: 十進カウンタ回路 テストベンチ
// Ver: 0.1 (2025/7/7)
// Copyright (c) 2025 Chimipupu(https://github.com/Chimipupu) All Rights Reserved.

module counter_test;
    reg CLK, RES;
    wire [3:0] Q;

    // インスタンス化: counterモジュール (CLK, RES, Q)
    counter i0(CLK, RES, Q);

    // クロック信号の生成: 5nsごとに反転 → 10ns周期 (100MHz)
    always #5 CLK = ~CLK;

    // 初期化とリセット制御
    initial begin
        CLK = 0;    // クロック初期値
        RES = 0;    // リセット初期値 (非アサート)
        #23 RES = 1; // 23ns後にリセットをアサート
        #150 $finish; // 150ns後にシミュレーション終了
    end

    // シミュレーション出力の設定
    initial begin
        $monitor("CLK=%d, RES=%d, Q=%d", CLK, RES, Q);
        $dumpfile("counter.vcd");
        $dumpvars(0, counter_test);
    end

endmodule