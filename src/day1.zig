const std = @import("std");
const utils = @import("utils.zig");

fn parseLine(line: []const u8) !struct { left: i32, right: i32 } {
    var iter = std.mem.window(u8, line, 5, 8);

    const left = try std.fmt.parseInt(i32, iter.next().?, 10);
    const right = try std.fmt.parseInt(i32, iter.next().?, 10);

    return .{ .left = left, .right = right };
}

fn readInput() !struct { left: [1000]i32, right: [1000]i32 } {
    const file = try std.fs.cwd().openFile("src/day1_input", .{});
    defer file.close();

    var left: [1000]i32 = undefined;
    var right: [1000]i32 = undefined;

    var i: u16 = 0;
    while (i < 1000) : (i += 1) {
        var buf: [14]u8 = undefined;
        const line = (try utils.nextLine(file.reader(), &buf)).?;
        const parsed = try parseLine(line);
        left[i] = parsed.left;
        right[i] = parsed.right;
    }

    return .{ .left = left, .right = right };
}

pub fn part1() !i32 {
    var input = try readInput();
    std.mem.sort(i32, &input.left, {}, comptime std.sort.asc(i32));
    std.mem.sort(i32, &input.right, {}, comptime std.sort.asc(i32));

    var diff: i32 = 0;
    var i: u16 = 0;
    while (i < input.left.len) : (i += 1) {
        diff += utils.abs(input.left[i] - input.right[i]);
    }

    return diff;
}

pub fn part2() !i32 {
    const input = try readInput();

    const alloc = std.heap.page_allocator;

    var map = std.AutoHashMap(i32, i32).init(alloc);
    defer map.deinit();

    var i: u16 = 0;
    while (i < input.right.len) : (i += 1) {
        const old = map.get(input.right[i]) orelse 0;
        try map.put(input.right[i], old + 1);
    }

    var sim: i32 = 0;
    i = 0;
    while (i < input.left.len) : (i += 1) {
        const n = map.get(input.left[i]) orelse 0;
        sim += input.left[i] * n;
    }

    return sim;
}
