/// <summary>
/// PageExtension ExtendNavigationArea (ID 50120) extends Record Order Processor Role Center.
/// </summary>
pageextension 50003 ExtendNavigationArea extends "Accountant Role Center"
{

    actions
    {
        addlast(Sections)
        {
            group("Special Tools")
            {

                // Creates a sub-menu
                group("Payroll")
                {
                    action("import Payroll to Journal")
                    {
                        ApplicationArea = All;
                        RunObject = report "Import Payroll to Gen Journal";
                    }
                    action("Payroll Journal")
                    {
                        ApplicationArea = All;
                        RunObject = page "Payroll Journal";
                    }
                }

                group("Branch")
                {
                    action("import Branch Journal")
                    {
                        ApplicationArea = All;
                        RunObject = report "Import Branch Journal";
                    }

                    group("Branch Setup")
                    {
                        action("Import branch Setup")
                        {
                            ApplicationArea = All;
                            RunObject = page "Import Branches Setup";
                        }

                    }

                }
                group("Periodic Activities")
                {
                    action("Modify Posted Dimension")
                    {
                        ApplicationArea = All;
                        RunObject = Page "Modify Posted Dimension";
                    }
                }
                group("Special Reports")
                {
                    action("Financial Report - Donor")
                    {
                        ApplicationArea = All;
                        RunObject = report "Financial Report - Donor";
                    }
                    action("Financial Report - Project")
                    {
                        ApplicationArea = All;
                        RunObject = report "Financial Report - Project";
                    }
                    action("Financial Report - Activity")
                    {
                        ApplicationArea = all;
                        RunObject = report "Financial Report - Activity";
                    }
                    action("Actual vs. budget")
                    {
                        ApplicationArea = All;
                        RunObject = report "Actual vs. Budget";
                    }
                    action("Bank Balances At Date")
                    {
                        ApplicationArea = All;
                        RunObject = report "Bank Balances At Date";
                    }
                    action("Bank Recon. - Report")
                    {
                        ApplicationArea = All;
                        RunObject = report "Vega Bank Recon.-Test";
                    }

                }

            }
        }
    }
}