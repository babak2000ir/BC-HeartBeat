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
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                    LedgerEntry: Record "G/L Entry";
                    Company: Record Company;
                    ExtendedText: Record "Extended Text Line";
                    ItemTranslation: Record "Item Translation";
                    TxtBuilder: TextBuilder;
                    TempBlob: Codeunit "Temp Blob";
                    is: InStream;
                    os: OutStream;
                    txtDummy: Text;
                    counter: Integer;
                    //CRLF: Text[2];
                    Tab: Text[1];
                    ltxtResult: Text;
                    ltxtByte: Text;
                begin
                    Tab[1] := 9;

                    Customer.reset;
                    Customer.FindSet();
                    repeat
                        TxtBuilder.AppendLine(Format(Customer.RecordId) + Tab + Format(Customer.RecordId, 0, 10) + Tab + Base64ToBinaryString(Format(Customer.RecordId, 0, 10)) + Tab + DecodeBookmark(Format(Customer.RecordId, 0, 10)));
                    until Customer.Next() = 0;

                    Vendor.reset;
                    Vendor.FindSet();
                    repeat
                        TxtBuilder.AppendLine(Format(Vendor.RecordId) + Tab + Format(Vendor.RecordId, 0, 10) + Tab + Base64ToBinaryString(Format(Vendor.RecordId, 0, 10)) + Tab + DecodeBookmark(Format(Vendor.RecordId, 0, 10)));
                    until Vendor.Next() = 0;

                    SalesLine.reset;
                    SalesLine.FindSet();
                    repeat
                        TxtBuilder.AppendLine(Format(SalesLine.RecordId) + Tab + Format(SalesLine.RecordId, 0, 10) + Tab + Base64ToBinaryString(Format(SalesLine.RecordId, 0, 10)) + Tab + DecodeBookmark(Format(SalesLine.RecordId, 0, 10)));
                    until SalesLine.Next() = 0;

                    Company.reset;
                    Company.FindSet();
                    repeat
                        TxtBuilder.AppendLine(Format(Company.RecordId) + Tab + Format(Company.RecordId, 0, 10) + Tab + Base64ToBinaryString(Format(Company.RecordId, 0, 10)) + Tab + DecodeBookmark(Format(Company.RecordId, 0, 10)));
                    until Company.Next() = 0;

                    CustLedgerEntry.reset;
                    CustLedgerEntry.FindSet();
                    repeat
                        TxtBuilder.AppendLine(Format(CustLedgerEntry.RecordId) + Tab + Format(CustLedgerEntry.RecordId, 0, 10) + Tab + Base64ToBinaryString(Format(CustLedgerEntry.RecordId, 0, 10)) + Tab + DecodeBookmark(Format(CustLedgerEntry.RecordId, 0, 10)));
                    until CustLedgerEntry.Next() = 0;

                    LedgerEntry.reset;
                    LedgerEntry.FindSet();
                    repeat
                        TxtBuilder.AppendLine(Format(LedgerEntry.RecordId) + Tab + Format(LedgerEntry.RecordId, 0, 10) + Tab + Base64ToBinaryString(Format(LedgerEntry.RecordId, 0, 10)) + Tab + DecodeBookmark(Format(LedgerEntry.RecordId, 0, 10)));
                    until LedgerEntry.Next() = 0;

                    ExtendedText.reset;
                    ExtendedText.FindSet();
                    repeat
                        TxtBuilder.AppendLine(Format(ExtendedText.RecordId) + Tab + Format(ExtendedText.RecordId, 0, 10) + Tab + Base64ToBinaryString(Format(ExtendedText.RecordId, 0, 10)) + Tab + DecodeBookmark(Format(ExtendedText.RecordId, 0, 10)));
                    until ExtendedText.Next() = 0;

                    ItemTranslation.reset;
                    ItemTranslation.FindSet();
                    repeat
                        TxtBuilder.AppendLine(Format(ItemTranslation.RecordId) + Tab + Format(ItemTranslation.RecordId, 0, 10) + Tab + Base64ToBinaryString(Format(ItemTranslation.RecordId, 0, 10)) + Tab + DecodeBookmark(Format(ItemTranslation.RecordId, 0, 10)));
                    until ItemTranslation.Next() = 0;

                    TempBlob.CreateOutStream(os, TextEncoding::UTF16);
                    os.Write(TxtBuilder.ToText());

                    TempBlob.CreateInStream(is, TextEncoding::UTF16);
                    txtDummy := 'Bookmark List.txt';
                    DownloadFromStream(is, '', '', '', txtDummy);
                    // CRLF[1] := 10;
                    // CRLF[2] := 13;

                    // for counter := 1 to 255 do begin
                    //     ltxtByte := Byte2BinaryText(counter);
                    //     ltxtResult += CRLF + CopyStr(lblLeadingZero, 1, 8 - StrLen(ltxtByte)) + ltxtByte;
                    // end;

                    // Message(ltxtResult);
                end;
            }

            action(UnicodeTest)
            {
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                var
                    ltxtResult: Text;
                    lByte: Byte;
                    lint: Integer;
                begin
                    //ltxtResult := 'بابک';

                    // lint := ltxtResult[1];
                    // lint := ltxtResult[2];
                    // lint := ltxtResult[3];
                    // lint := ltxtResult[4];
                    // lint := ltxtResult[5];
                    // lint := ltxtResult[6];
                    // lint := ltxtResult[7];
                    // lint := ltxtResult[8];
                    // lint := ltxtResult[9];

                    ltxtResult[1] := 1576;
                    ltxtResult[2] := 1575;
                    ltxtResult[3] := 1576;
                    ltxtResult[4] := 1705;

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
        Base64Text := ConvertStr(Base64Text, ';', ',');
        Base64Text := SelectStr(2, Base64Text);

        TempBlob.CreateOutStream(os);
        Base64Helper.FromBase64(Base64Text, os);

        TempBlob.CreateInStream(is);

        repeat
            is.Read(lByte);
            if ltxtReturn = '' then
                ltxtReturn := Byte2BinaryTextPad(lByte)
            else
                ltxtReturn += ' ' + Byte2BinaryTextPad(lByte);
        until is.EOS();

        exit(ltxtReturn);
    end;

    procedure Byte2BinaryTextPad(pByte: Byte): Text
    var
        ltxtReturn: Text;
        lblLeadingZero: Label '00000000';
    begin
        ltxtReturn := Byte2BinaryText(pByte);
        ltxtReturn := CopyStr(lblLeadingZero, 1, 8 - StrLen(ltxtReturn)) + ltxtReturn;

        exit(ltxtReturn)
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

    procedure DecodeBookmark(Base64Text: Text): Text
    var
        Base64Helper: Codeunit "Base64 Convert";

        os: OutStream;
        TempBlob: Codeunit "Temp Blob";
        lByte: Byte;
        lint: Integer;
        ltxtReturn: Text;
        KeyPositions: List of [Integer];
        Counter: Integer;
    begin
        Base64Text := ConvertStr(Base64Text, ';', ',');
        Base64Text := SelectStr(2, Base64Text);

        TempBlob.CreateOutStream(os);
        Base64Helper.FromBase64(Base64Text, os);

        ltxtReturn := format(GetTableNo(TempBlob)) + ': ';
        GetKeyPos(TempBlob, KeyPositions);

        for Counter := 1 to KeyPositions.Count - 1 do begin
            ltxtReturn += GetKey(TempBlob, KeyPositions.Get(Counter), KeyPositions.Get(Counter + 1));
        end;

        exit(ltxtReturn);
    end;

    procedure GetTableNo(var pTempBlob: Codeunit "Temp Blob"): Integer
    var
        is: InStream;
        Offset: Integer;
        TableNo: Integer;
        lByte: Byte;
    begin
        pTempBlob.CreateInStream(is);

        Offset := 1;

        repeat
            case Offset of
                //00000000 00000000 00000010 01111011 key seperator
                1 .. 4:
                    begin
                        is.Read(lByte);
                        TableNo += Power(256, Offset - 1) * lbyte;
                    end;
                else begin
                        exit(TableNo);
                    end;
            end;

            Offset += 1;
        until is.EOS();

        exit(TableNo);
    end;

    procedure GetKeyPos(var pTempBlob: Codeunit "Temp Blob"; pKeyPositions: List of [Integer])
    var
        is: InStream;
        Offset: Integer;
        lByte: Byte;
        KeyPos: Integer;
        Step: Integer;
    begin
        pTempBlob.CreateInStream(is);

        Offset := 1;

        pKeyPositions.Add(8);

        repeat
            case Offset of
                1 .. 4:
                    begin
                    end;
                else begin
                        //00000000 00000000 00000010 01111011 key seperator
                        is.Read(lByte);
                        if (Step = 0) and (lByte = 0) then begin
                            KeyPos := Offset;
                            Step := 1;
                        end;

                        if (Step = 1) and (lByte = 0) then begin
                            step := 2;
                        end else begin
                            KeyPos := 0;
                            step := 0;
                        end;

                        if (Step = 2) and (lByte = 2) then begin
                            step := 3;
                        end else begin
                            if lByte = 0 then begin
                                KeyPos := Offset;
                                Step := 1;
                            end else begin
                                KeyPos := 0;
                                step := 0;
                            end;
                        end;

                        if (Step = 3) and (lByte = 123) then begin
                            step := 0;
                            pKeyPositions.Add(KeyPos);
                            KeyPos := 0;
                        end else begin
                            if lByte = 0 then begin
                                KeyPos := Offset;
                                Step := 1;
                            end else begin
                                KeyPos := 0;
                                step := 0;
                            end;
                        end;
                    end;
            end;

            Offset += 1;
        until is.EOS();

        pKeyPositions.Add(Offset - 1);
    end;

    procedure GetKey(var pTempBlob: Codeunit "Temp Blob"; FromOffset: Integer; ToOffset: Integer): Text
    var
        is: InStream;
        Offset: Integer;
        lByte: Byte;
        Step: Integer;
        Resolve: Boolean;
        CharInt: Integer;
        KeyString: Text;
        TargetOffset: Integer;
    begin
        pTempBlob.CreateInStream(is);

        Offset := 1;
        TargetOffset := 1;
        Step := 1;

        repeat
            is.Read(lByte);
            if (Offset >= FromOffset) and (Offset <= ToOffset) then begin
                if Step = 1 then begin
                    CharInt := lByte;
                    Resolve := true;
                end else begin
                    Resolve := false;
                    CharInt += 256 * lByte;

                    KeyString += ' ';
                    KeyString[TargetOffset] := CharInt;
                    TargetOffset += 1;
                end;
            end;

            Offset += 1;
        until is.EOS();

        if Resolve then begin
            KeyString += ' ';
            KeyString[TargetOffset] := CharInt;
            TargetOffset += 1;
        end;

        exit(KeyString)
    end;
}