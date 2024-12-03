const std = @import("std");

const day1 = @import("day1.zig");
const day2 = @import("day2.zig");
const day3 = @import("day3.zig");

pub fn main() !void {
    std.log.info("day1 part1: {any}", .{day1.part1()});
    std.log.info("day1 part2: {any}", .{day1.part2()});
    std.log.info("day2 part1: {any}", .{day2.part1()});
    std.log.info("day2 part2: {s}", .{"not solved yet"});
    std.log.info("day3 part1: {any}", .{day3.part1()});
    std.log.info("day3 part2: {any}", .{day3.part2()});
}
