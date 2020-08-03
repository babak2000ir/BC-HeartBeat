page 50201 "TPE Global Panel Init"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Name/Value Buffer";

    layout
    {
        area(Content)
        {
            usercontrol(GlobalPanelInit; "TPE Global Panel")
            {
                ApplicationArea = all;

                trigger GlobalPanelIsReady()
                begin

                end;

                trigger HeartBeat()
                begin

                end;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}