package raylib_bindings

import "core:fmt"
import "core:os"
import "core:io"
import "core:bufio"


main ::proc()
{
	input_stream := os.stream_from_handle(os.stdin);
	reader: bufio.Reader;
	bufio.reader_init(&reader, io.Reader{input_stream});
	line, err := bufio.reader_read_string(&reader, '\n');
	for  err == .None
	{
		fmt.print(line);
		line, err = bufio.reader_read_string(&reader, '\n')
	}
}
