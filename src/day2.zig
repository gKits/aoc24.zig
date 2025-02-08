const std = @import("std");
const utils = @import("utils.zig");
const alloc = std.heap.page_allocator;

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

fn lineIsSafe2(line: []const u8) !bool {
    var iter = std.mem.split(u8, line, " ");

    var list = std.ArrayList(i16).init(alloc);
    defer list.deinit();
    while (iter.next()) |x| {
        const cur = try std.fmt.parseInt(i16, x, 10);
        try list.append(cur);
    }

    const nums = list.items;

    var prev: usize = 0;
    var diff: i16 = 0;
    var sign: i16 = 0;
    var failed: bool = false;
    for (1..nums.len) |i| {
        diff = nums[prev] - nums[i];
        if (sign == 0) {
            sign = std.math.sign(diff);
        }
        if (std.math.sign(diff) != sign) {
            failed = true;
            break;
        }
        if (diff == 0 or diff < -3 or diff > 3) {
            failed = true;
            break;
        }
        prev = i;
    }

    if (failed) {
        return bruteForce(nums);
    }
    return true;
}

fn bruteForce(nums: []i16) bool {
    for (1..nums.len) |skip| {
        var prev: usize = 0;
        var diff: i16 = 0;
        var sign: i16 = 0;
        var failed: bool = false;
        for (1..nums.len) |i| {
            if (i == skip) {
                continue;
            }
            diff = nums[prev] - nums[i];
            if (sign == 0) {
                sign = std.math.sign(diff);
            }
            if (std.math.sign(diff) != sign) {
                if (i == 2) {
                    sign = 0;
                }
                failed = true;
                break;
            }
            if (diff == 0 or diff < -3 or diff > 3) {
                failed = true;
                break;
            }
            prev = i;
        }
        if (!failed) {
            return true;
        }
    }
    return false;
}

pub fn part1() !u16 {
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

    return count;
}

pub fn part2() !u16 {
    const file = try std.fs.cwd().openFile("src/day2_input", .{});
    defer file.close();

    var count: u16 = 0;
    var i: u16 = 0;
    while (i < 1000) : (i += 1) {
        var buf: [24]u8 = undefined;
        const line = (try utils.nextLine(file.reader(), &buf)).?;
        if (try lineIsSafe2(line)) {
            count += 1;
        }
    }

    return count;
}
