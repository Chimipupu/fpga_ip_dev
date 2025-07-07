# FPGA IP 個人開発

FPGAのIPを個人で開発

## 開発環境

- EDA
  - [Gowin EDA V1.9.11.03 (Windows x64)](https://cdn.gowinsemi.com.cn/Gowin_V1.9.11.03_x64_win.zip)🔗
- シミュレーション
  - [Icarus Verilog](https://bleyer.org/icarus/)🔗
  - [GTKWave](https://gtkwave.sourceforge.net/)🔗

```shell
> iverilog uart.v uart_tb.v
> vvp a.out
> gtkwave uart_tb.vcd
```
