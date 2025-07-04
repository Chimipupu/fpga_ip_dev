// UART送信モジュール（TX）
module uart_tx (
    input wire clk,
    input wire rst,
    input wire tx_start,
    input wire [7:0] tx_data,
    output reg tx,
    output reg tx_busy
);

    parameter CLK_FREQ = 50000000;
    parameter BAUD_RATE = 115200;
    localparam BAUD_DIV = CLK_FREQ / BAUD_RATE;

    reg [15:0] baud_cnt;
    reg [3:0] bit_idx;
    reg [9:0] shift_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx <= 1'b1;
            tx_busy <= 1'b0;
            baud_cnt <= 0;
            bit_idx <= 0;
            shift_reg <= 10'b1111111111;
        end else begin
            if (tx_start && !tx_busy) begin
                shift_reg <= {1'b1, tx_data, 1'b0};
                tx_busy <= 1'b1;
                baud_cnt <= 0;
                bit_idx <= 0;
            end else if (tx_busy) begin
                if (baud_cnt < BAUD_DIV - 1) begin
                    baud_cnt <= baud_cnt + 1;
                end else begin
                    baud_cnt <= 0;
                    tx <= shift_reg[0];
                    shift_reg <= {1'b1, shift_reg[9:1]};
                    bit_idx <= bit_idx + 1;
                    if (bit_idx == 9) begin
                        tx_busy <= 1'b0;
                    end
                end
            end
        end
    end
endmodule

// UART受信モジュール（RX）
module uart_rx (
    input wire clk,
    input wire rst,
    input wire rx,
    output reg [7:0] rx_data,
    output reg rx_done
);

    parameter CLK_FREQ = 50000000;
    parameter BAUD_RATE = 115200;
    localparam BAUD_DIV = CLK_FREQ / BAUD_RATE;

    reg [15:0] baud_cnt;
    reg [3:0] bit_idx;
    reg [7:0] data_buf;
    reg receiving;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            baud_cnt <= 0;
            bit_idx <= 0;
            data_buf <= 0;
            rx_data <= 0;
            rx_done <= 0;
            receiving <= 0;
        end else begin
            rx_done <= 0;
            if (!receiving) begin
                if (!rx) begin
                    receiving <= 1;
                    baud_cnt <= 0;  // ここをBAUD_DIV/2から0に変更
                    bit_idx <= 0;
                end
            end else begin
                if (baud_cnt < BAUD_DIV - 1) begin
                    baud_cnt <= baud_cnt + 1;
                end else begin
                    baud_cnt <= 0;
                    if (bit_idx < 8) begin
                        data_buf[bit_idx] <= rx;
                        bit_idx <= bit_idx + 1;
                    end else begin
                        rx_data <= data_buf;
                        rx_done <= 1;
                        receiving <= 0;
                    end
                end
            end
        end
    end
endmodule