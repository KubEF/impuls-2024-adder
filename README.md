# Тестовое задание от команды AI.Hardware

Задание заключалось в использовании любой библиотеки на Verilog или SystemVerilog, которая реализует float32 и сложить 2 числа. В его рамках было сделано:

* Написан модуль `add`, который использует сложение чисел из библиотеки [fpu](https://github.com/dawsonjon/fpu).
* Написан testbench модуль `add_tb`, который на небольшом количестве примеров проверят корректность работы программы.
* Написан Makefile для сборки и запуска testbench файла.
