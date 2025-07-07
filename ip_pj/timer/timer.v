// IP: タイマー モジュール
// Ver: 0.1 (2025/7/7)
// Copyright (c) 2025 Chimipupu(https://github.com/Chimipupu) All Rights Reserved.

module timer #(parameter WIDTH = 32)(
    input wire clk,
    input wire rst,
    input wire en,
    input wire oneshot,              // 1: ワンショット, 0: インターバル
    input wire [WIDTH-1:0] compare_val,
    output reg [WIDTH-1:0] count,
    output reg irq
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 0;
        irq <= 0;
    end else if (en) begin
        if (count + 1 >= compare_val) begin
            irq <= 1;
            if (oneshot)
                count <= count;       // ワンショット: カウント停止
            else
                count <= 0;           // インターバル: リスタート
        end else begin
            count <= count + 1;
            irq <= 0;
        end
    end else begin
        irq <= 0;
    end
end

endmodule