// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50200 "TPE CustomerListExt" extends "Customer List"
{
    layout
    {
        addfirst(factboxes)
        {
            part("Global Panel Init"; "TPE Global Panel Init")
            {
                ApplicationArea = all;
            }
        }
    }
}