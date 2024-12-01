const std = @import("std");

pub fn nextLine(reader: anytype, buf: []u8) !?[]const u8 {
    const line = (try reader.readUntilDelimiterOrEof(buf, '\n')) orelse return null;
    return line;
}

pub fn abs(x: anytype) @TypeOf(x) {
    if (x < 0) {
        return -x;
    }
    return x;
}
