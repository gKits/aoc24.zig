const std = @import("std");

const day1 = @import("day1.zig");
const day2 = @import("day2.zig");
const day3 = @import("day3.zig");

test {
    std.testing.log_level = .debug;
    std.testing.refAllDecls(@This());
}
