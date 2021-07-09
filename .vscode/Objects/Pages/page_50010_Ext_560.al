pageextension 50010 Dimensionvaluelist extends "Dimension Value List" //OriginalId
{
  
    layout
    {
        addafter(Totaling)
        {
            field(DonorCode; DonorCode)
            {
                ApplicationArea = All;
            }
        }
    }
}