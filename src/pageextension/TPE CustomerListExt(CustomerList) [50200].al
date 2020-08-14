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

    actions
    {
        addlast(processing)
        {
            action(Generate)
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                var
                    Customer: Record Customer;
                    Vendor: Record Vendor;
                    SalesLine: Record "Sales Line";
                    TxtBuilder: TextBuilder;
                    TempBlob: Codeunit "Temp Blob";
                    is: InStream;
                    os: OutStream;
                    txtDummy: Text;
                    counter: Integer;
                    CRLF: Text[2];
                    ltxtResult: Text;
                    ltxtByte: Text;
                    lblLeadingZero: Label '00000000';
                begin
                    // Customer.reset;
                    // Customer.FindSet();
                    // repeat
                    //     TxtBuilder.AppendLine(Format(Customer.RecordId) + ': ' + Format(Customer.RecordId, 0, 10));
                    // until Customer.Next() = 0;

                    // Vendor.reset;
                    // Vendor.FindSet();
                    // repeat
                    //     TxtBuilder.AppendLine(Format(Vendor.RecordId) + ': ' + Format(Vendor.RecordId, 0, 10));
                    // until Vendor.Next() = 0;

                    // SalesLine.reset;
                    // SalesLine.FindSet();
                    // repeat
                    //     TxtBuilder.AppendLine(Format(SalesLine.RecordId) + ': ' + Format(SalesLine.RecordId, 0, 10));
                    // until SalesLine.Next() = 0;

                    // TempBlob.CreateOutStream(os);
                    // os.Write(TxtBuilder.ToText());

                    // TempBlob.CreateInStream(is);
                    // DownloadFromStream(is, '', '', '', txtDummy);
                    CRLF[1] := 10;
                    CRLF[2] := 13;

                    for counter := 1 to 255 do begin
                        ltxtByte := Byte2BinaryText(counter);
                        ltxtResult += CRLF + CopyStr(lblLeadingZero, 1, 8 - StrLen(ltxtByte)) + ltxtByte;
                    end;

                    Message(ltxtResult);
                end;
            }
        }
    }

    procedure Base64ToBinaryString(Base64Text: Text): Text
    var
        Base64Helper: Codeunit "Base64 Convert";
        is: InStream;
        os: OutStream;
        TempBlob: Codeunit "Temp Blob";
        lByte: Byte;
        ltxtReturn: Text;
    begin
        TempBlob.CreateOutStream(os);
        Base64Helper.FromBase64(Base64Text, os);

        TempBlob.CreateInStream(is);

        repeat
            is.Read(lByte);
            if ltxtReturn = '' then
                ltxtReturn := Byte2BinaryText(lByte)
            else
                ltxtReturn := ' ' + CopyStr(Byte2BinaryText(lByte), 1, 8 - StrLen(ltxtReturn));
        until is.EOS();

        exit(ltxtReturn);
    end;

    procedure Byte2BinaryText(pByte: Byte): Text
    var
        lResult: Integer;
        lRemainder: Integer;
        ltxtReturn: Text;
    begin
        lResult := pByte Div 2;
        lRemainder := pByte Mod 2;

        if lResult > 1 then begin
            ltxtReturn += Byte2BinaryText(lResult) + Format(lRemainder);
        end else begin
            ltxtReturn := Format(lResult) + Format(lRemainder);
        end;

        exit(ltxtReturn)
    end;

}