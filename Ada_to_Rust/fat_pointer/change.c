typedef struct
{
  int first;
  int last;
} AdaBounds;

typedef struct
{
  char *data;
  AdaBounds *bounds;
} AdaString;

extern void change(AdaString s)
{
  s.data[0] = 'w';
  s.data[1] = 'o';
  s.data[2] = 'r';
  s.data[3] = 'l';
  s.data[4] = 'd';

  // let new_data = "world".as_bytes();
  // s.data[..new_data.len()].copy_from_slice(new_data);
}
