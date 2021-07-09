/// <summary>
/// PageExtension Extend General ledger setup (ID 50004) extends Record General Ledger Setup.
/// </summary>
pageextension 50004 "Extend General ledger setup" extends "General Ledger Setup"
{
    layout
    {
        addafter("Shortcut Dimension 8 Code")
        {
            field(ActivityShowDonorCode; ActivityShowDonorCode)
            {

            }
            field(ActivityShowDonorActivity; ActivityShowDonorActivity)
            {

            }
            field(DonorActivityShowDonorCode; DonorActivityShowDonorCode)
            {

            }
            field(ProjectShowDonorCode; ProjectShowDonorCode)
            {

            }
            field(DonorActivityShowActivityCode; DonorActivityShowActivityCode)
            {

            }

        }
        addafter(Application)
        {
            group("RC Reporting")
            {
                field("Opening Balance A/C Filter"; "Opening Balance A/C Filter")
                {
                    ApplicationArea = all;
                }
                field("Income A/C Filter"; "Income A/C Filter")
                {
                    ApplicationArea = all;
                }
                field("Transfer A/C Filter"; "Transfers A/C Filter")
                {
                    ApplicationArea = all;
                }
                field("Expense A/C Filter"; "Expense A/C Filter")
                {
                    ApplicationArea = all;
                }
                field("Cash at Bank A/C Filter"; "Cash at Bank A/C Filter")
                {
                    ApplicationArea = all;
                }
                field("Cash at Hand A/C Filter"; "Cash at Hand A/C Filter")
                {
                    ApplicationArea = all;
                }
                field("Working Advance A/C Filter"; "Working Advance A/C Filter")
                {
                    ApplicationArea = all;
                }
                field("Other A/C Filter"; "Other A/C Filter")
                {
                    ApplicationArea = all;
                }
                field("Payable A/C Filter"; "Payable A/C Filter")
                {
                    ApplicationArea = all;
                }
                field("Cutoff Date"; "Cutoff Date")
                {
                    ApplicationArea = all;
                }
                field("Prior Year Adjust. Filter"; "Prior Year Adjust. Filter")
                {
                    ApplicationArea = all;
                }
                field("Revaluation Gain/Loss Filter"; "Revaluation Gain/Loss Filter")
                {
                    ApplicationArea = all;
                }
                field("Donor Dimension"; "Donor Dimension")
                {
                    ApplicationArea = all;
                }
                field("Project Dimension"; "Project Dimension")
                {
                    ApplicationArea = all;
                }
                field("Activity Dimension"; "Activity Dimension")
                {
                    ApplicationArea = all;
                }

            }
        }
    }
}