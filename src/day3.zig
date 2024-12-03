const std = @import("std");
const mvzr = @import("mvzr");
const alloc = std.heap.page_allocator;

fn parseAndMultiply(toParse: []const u8) !i32 {
    var iter = std.mem.split(u8, toParse[4 .. toParse.len - 1], ",");

    const first = try std.fmt.parseInt(i32, iter.next().?, 10);
    const second = try std.fmt.parseInt(i32, iter.next().?, 10);

    return first * second;
}

pub fn part1() !i32 {
    var file = try std.fs.cwd().openFile("src/day3_input", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    var buf: [8096]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        try list.appendSlice(line);
    }

    const pattern = "mul\\(\\d{1,3},\\d{1,3}\\)";
    const re = mvzr.compile(pattern).?;
    const heap_re = try re.toOwnedRegex(alloc);
    defer alloc.destroy(heap_re);

    var iter = re.iterator(list.items);

    var sum: i32 = 0;
    while (iter.next()) |x| {
        sum += try parseAndMultiply(x.slice);
    }

    return sum;
}

pub fn part2() !i32 {
    var file = try std.fs.cwd().openFile("src/day3_input", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var list = std.ArrayList(u8).init(alloc);
    defer list.deinit();
    var buf: [8096]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        try list.appendSlice(line);
    }

    const pattern = "mul\\(\\d{1,3},\\d{1,3}\\)|do\\(\\)|don't\\(\\)";
    const re = mvzr.compile(pattern).?;
    const heap_re = try re.toOwnedRegex(alloc);
    defer alloc.destroy(heap_re);

    var iter = re.iterator(list.items);

    var sum: i32 = 0;
    var active: bool = true;
    while (iter.next()) |x| {
        if (std.mem.eql(u8, x.slice, "do()")) {
            active = true;
        } else if (std.mem.eql(u8, x.slice, "don't()")) {
            active = false;
        } else if (active) {
            sum += try parseAndMultiply(x.slice);
        }
    }

    return sum;
}
