procedure Incorrect_record is
type Point is record
X,Y : Integer := 0;
end record;

My_record: Point := ( X=> 3);
-- even when nothing happens need a begin and an end
begin
null;
    
end Incorrect_record;