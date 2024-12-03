const std = @import("std");
const utils = @import("utils.zig");
const alloc = std.testing.allocator;

fn lineIsSafe(line: []const u8) !bool {
    var iter = std.mem.split(u8, line, " ");

    var diff: i16 = 0;
    var prev = try std.fmt.parseInt(i16, iter.first(), 10);
    var sign: i16 = 0;
    while (iter.next()) |x| {
        const cur = try std.fmt.parseInt(i16, x, 10);
        diff = prev - cur;
        if (sign == 0) {
            sign = std.math.sign(diff);
        }
        if (std.math.sign(diff) != sign) {
            return false;
        }
        if (diff == 0 or diff < -3 or diff > 3) {
            return false;
        }
        prev = cur;
    }

    return true;
}

test "day2: part1" {
    const file = try std.fs.cwd().openFile("src/day2_input", .{});
    defer file.close();

    var count: u16 = 0;
    var i: u16 = 0;
    while (i < 1000) : (i += 1) {
        var buf: [24]u8 = undefined;
        const line = (try utils.nextLine(file.reader(), &buf)).?;
        if (try lineIsSafe(line)) {
            count += 1;
        }
    }

    std.debug.print(" res: {d} ", .{count});
}
