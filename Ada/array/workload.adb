with Ada.Text_IO; use Ada.Text_IO;

procedure Workload is
type Day is (Monday, Tuesday, Wednesday, Thursday, Friday);
type Workload_type is array (Day range <>) of Integer;
Workload: Workload_type (Monday..Friday) := (Friday => 7, others => 8);

-- missing begin
begin
for W in Workload'Range loop
-- spottar ut en integer, the array is workload, indexed by W
Put_Line(Day'Image(W) & Integer'Image(Workload(W)));
end loop;
end Workload;