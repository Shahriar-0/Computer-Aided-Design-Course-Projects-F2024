from copy import deepcopy

RC_PATH = "trunk/sim/file/rc.hex"
ITER_COUNT = 24

rotation_changes: dict[tuple[int, int], int] = {
    (0, 0): 0,
    (0, 1): 36,
    (0, 2): 3,
    (0, 3): 41,
    (0, 4): 18,
    (1, 0): 1,
    (1, 1): 44,
    (1, 2): 10,
    (1, 3): 45,
    (1, 4): 2,
    (2, 0): 62,
    (2, 1): 6,
    (2, 2): 43,
    (2, 3): 15,
    (2, 4): 61,
    (3, 0): 28,
    (3, 1): 55,
    (3, 2): 25,
    (3, 3): 21,
    (3, 4): 56,
    (4, 0): 27,
    (4, 1): 20,
    (4, 2): 39,
    (4, 3): 8,
    (4, 4): 14,
}
rc_values: list[str] = []


def read_rc() -> None:
    with open(RC_PATH, "r") as f:
        for line in f:
            bits = bin(int(line, 16))[2:].zfill(64)
            rc_values.append(bits)


def index_2d_to_1d(x: int, y: int) -> int:
    col = (x + 2) % 5
    row = (y + 2) % 5
    return col + 5 * row


def index_1d_to_2d(index: int) -> tuple[int, int]:
    col = index % 5
    row = index // 5
    return (col + 3) % 5, (row + 3) % 5


def add_rc(data: list[list[int]], itr: int) -> list[list[int]]:
    data = deepcopy(data)
    for i in range(len(data)):
        data[i][12] ^= int(rc_values[itr][i])
    return data


def revaluate(data: list[list[int]]) -> list[list[int]]:
    result = deepcopy(data)
    for i, slice in enumerate(data):
        for j, bit in enumerate(slice):
            x, y = index_1d_to_2d(j)
            a = bit
            b = data[i][index_2d_to_1d((x + 1) % 5, y)]
            c = data[i][index_2d_to_1d((x + 2) % 5, y)]
            result[i][j] = a ^ (int(not b) & c)
    return result


def permute(data: list[list[int]]) -> list[list[int]]:
    result = deepcopy(data)
    for i, slice in enumerate(data):
        for j, bit in enumerate(slice):
            x, y = index_1d_to_2d(j)
            result[i][index_2d_to_1d(y, (2 * x + 3 * y) % 5)] = bit
    return result


def rotate(data: list[list[int]]) -> list[list[int]]:
    result = deepcopy(data)
    for i in range(64):
        for j in range(25):
            x, y = index_1d_to_2d(j)
            result[i][j] = data[(i + 64 - rotation_changes[(x, y)]) % 64][j]
    return result


def col_parity(data: list[list[int]]) -> list[list[int]]:
    result = deepcopy(data)
    for i, slice in enumerate(data):
        for j, bit in enumerate(slice):
            x, _ = index_1d_to_2d(j)
            a = bit
            b, c = 0, 0
            for k in range(5):
                b ^= data[i][index_2d_to_1d((x + 4) % 5, k)]
                c ^= data[(i + 63) % 64][index_2d_to_1d((x + 1) % 5, k)]
            result[i][j] = a ^ b ^ c
    return result


def encode(data: list[list[int]]) -> list[list[int]]:
    for i in range(ITER_COUNT):
        data = col_parity(data)
        data = rotate(data)
        data = permute(data)
        data = revaluate(data)
        data = add_rc(data, i)
    return data


def get_input() -> list[list[int]]:
    data = []
    for _ in range(64):
        line = list(map(int, list(input())))
        data.append(line)
    return data


def print_output(data: list[list[int]]) -> None:
    for line in data:
        print(''.join(map(str, line)))


def main():
    read_rc()
    data = get_input()
    data = encode(data)
    print_output(data)


if __name__ == "__main__":
    main()
