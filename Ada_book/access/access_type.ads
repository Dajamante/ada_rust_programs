-- pointers should be declared in ads file!
-- here I have a typo, one is called date, the other dates
-- error: subtype indication expected
with Dates; use Dates;

-- and it is a package

-- same name as package
package Access_type is
-- type Date_access is access of Date the "of" is wrong!
    -- error: subtype indication expected
    type Date_access is access Date;
    -- will that be default values?

    type String_access is access String;

    -- you need to use new or wrong type obviously
    My_access: Date_access := new Date;
    -- must be new String!! with appartenance '
    My_second_access : String_access := new String'("hello");
end Access_type;