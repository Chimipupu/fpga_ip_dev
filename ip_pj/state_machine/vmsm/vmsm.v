// IP: ステートマシンの練習（自動販売機）
// Ver: 0.1 (2025/7/7)
// Copyright (c) 2025 Chimipupu(https://github.com/Chimipupu) All Rights Reserved.

module vmsm(
    input wire clk,
    input wire reset_n
);

    // 自動販売機のステートマシン
    parameter SM_IDLE           = 2'b00; // コイン待機ステート
    parameter SM_COIN_INSERTED  = 2'b01; // コイン受付ステート
    parameter SM_DISPENSING     = 2'b10; // 商品排出ステート
    parameter SM_CHANGE_RETURN  = 2'b11; // お釣り返却ステート

    // ステートレジスタ
    reg [1:0] reg_state;

    // 状態遷移ロジック
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            reg_state <= SM_IDLE;
        end else begin
            case (reg_state)
                SM_IDLE:
                    reg_state <= SM_COIN_INSERTED;
                SM_COIN_INSERTED:
                    reg_state <= SM_DISPENSING;
                SM_DISPENSING:
                    reg_state <= SM_CHANGE_RETURN;
                SM_CHANGE_RETURN:
                    reg_state <= SM_IDLE;
                default:
                    reg_state <= SM_IDLE;
            endcase
        end
    end

    always @(reg_state) begin
        $display("reg_state = 0x%02X", reg_state);
        case (reg_state)
            SM_IDLE:
                $display("コイン待機ステート");
            SM_COIN_INSERTED:
                $display("コイン受付ステート");
            SM_DISPENSING:
                $display("商品排出ステート");
            SM_CHANGE_RETURN:
                $display("お釣り返却ステート");
        endcase
    end
endmodule