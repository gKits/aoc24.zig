const std = @import("std");

pub fn part1() !i32 {
    var file = try std.fs.cwd().openFile("src/day4_input", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var input: [140][]u8 = undefined;

    var buf: [141]u8 = undefined;
    var l: usize = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        input[l] = line;
        l = l + 1;
    }

    var count: i32 = 0;
    var xmas = [4]u8{ 'X', 'M', 'A', 'S' };

    for (input, 0..) |line, i| {
        for (line, 0..) |c, j| {
            if (c != 'X') {
                continue;
            }
            var cmp: [4]u8 = undefined;

            // Right
            if (j < line.len - 3) {
                cmp = [4]u8{ input[i][j], input[i][j + 1], input[i][j + 2], input[i][j + 3] };
                std.log.debug("{d}: Right {s}", .{ j, cmp });
                if (std.mem.eql(u8, &xmas, &cmp)) {
                    count = count + 1;
                }
            }
            // Left
            if (j >= 3) {
                cmp = [4]u8{ input[i][j], input[i][j - 1], input[i][j - 2], input[i][j - 3] };
                std.log.debug("{d}: Left {s}", .{ j, cmp });
                if (std.mem.eql(u8, &xmas, &cmp)) {
                    count = count + 1;
                }
            }
            // Down
            if (i < input.len - 3) {
                cmp = [4]u8{ input[i][j], input[i + 1][j], input[i + 2][j], input[i + 3][j] };
                std.log.debug("{d}: Down {s}", .{ j, cmp });
                if (std.mem.eql(u8, &xmas, &cmp)) {
                    count = count + 1;
                }
            }
            // Up
            if (i >= 3) {
                cmp = [4]u8{ input[i][j], input[i - 1][j], input[i - 2][j], input[i - 3][j] };
                std.log.debug("{d}: Up {s}", .{ j, cmp });
                if (std.mem.eql(u8, &xmas, &cmp)) {
                    count = count + 1;
                }
            }
            // Down-Right
            if (i < input.len - 3 and j < line.len - 3) {
                cmp = [4]u8{ input[i][j], input[i + 1][j + 1], input[i + 2][j + 2], input[i + 3][j + 3] };
                std.log.debug("{d}: Down-Right {s}", .{ j, cmp });
                if (std.mem.eql(u8, &xmas, &cmp)) {
                    count = count + 1;
                }
            }
            // Up-Right
            if (i >= 3 and j < line.len - 3) {
                cmp = [4]u8{ input[i][j], input[i - 1][j + 1], input[i - 2][j + 2], input[i - 3][j + 3] };
                std.log.debug("{d}: Up-Right {s}", .{ j, cmp });
                if (std.mem.eql(u8, &xmas, &cmp)) {
                    count = count + 1;
                }
            }
            // Down-Left
            if (i < input.len - 3 and j >= 3) {
                cmp = [4]u8{ input[i][j], input[i + 1][j - 1], input[i + 2][j - 2], input[i + 3][j - 3] };
                std.log.debug("{d}: Down-Left {s}", .{ j, cmp });
                if (std.mem.eql(u8, &xmas, &cmp)) {
                    count = count + 1;
                }
            }
            // Up-Left
            if (i >= 3 and j >= 3) {
                cmp = [4]u8{ input[i][j], input[i - 1][j - 1], input[i - 2][j - 2], input[i - 3][j - 3] };
                std.log.debug("{d}: Up-Left {s}", .{ j, cmp });
                if (std.mem.eql(u8, &xmas, &cmp)) {
                    count = count + 1;
                }
            }
        }
    }

    return count;
}
