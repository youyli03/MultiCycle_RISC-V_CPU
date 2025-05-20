import sys

def convert_hex_file(input_file, output_file):
    with open(input_file, 'r') as f:
        lines = f.readlines()

    with open(output_file, 'w') as f:
        address = 0
        addr_cnt = 0
        for line in lines:
            # print(line)
            if line.startswith('@'):
                # 提取地址并转换为整数
                address = int((int(line[1:-1], 16) - 0x80000000)/4)
                print('address',"{:0x}".format(address),"d:",address)
                if address == 0 :
                    addr_cnt = 0
                else:
                    for i in range(addr_cnt,address):
                        f.write('00000000')
                        f.write('\n')
                print(addr_cnt)
            elif len(line.strip()) > 0:
                # 将每行的数据转换为指定格式
                hex_data = line.strip().split()
                cnt = 0
                _str = ""
                for i, value in enumerate(hex_data):
                    _str = value + _str
                    cnt += 1
                    if(cnt == 4):
                        # addr_str = "{:0x}".format(address + addr_cnt)
                        # print( addr_cnt ,_str,end=" ")
                        # f.write(f"{addr_str}:{_str}")
                        f.write(_str)
                        _str = ""
                        cnt = 0
                        addr_cnt += 1
                        f.write('\n')
                # print()

# 调用函数进行转换
if __name__ == "__main__":
    print('v2hex')
    if len(sys.argv) != 3:
        print("Usage: python v2hex.py <input_file> <output_file>")
        sys.exit(1)
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    convert_hex_file(input_file, output_file)