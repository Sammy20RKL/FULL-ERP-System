page 53075 "Procurement Role Centre"
{
    PageType = RoleCenter;
    Extensible = true;

    layout
    {
        area(rolecenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = All;
                Caption = 'Headline RC Accountant';
                Visible = false;
            }
            part("Procurement Management Cue"; "Procurement Management Cues")
            {
                ApplicationArea = All;
                Caption = 'Procurement Management Cues';
            }
            group(Control1900724808)
            {
                ShowCaption = false;
                Caption = 'Control1900724808';

                part(Control1907662708; "Purchase Agent Activities")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Agent Activities';
                }
                part(Control1902476008; "My Vendors")
                {
                    ApplicationArea = All;
                    Caption = 'My Vendors';
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;
                Caption = 'Control1900724708';

                part(Control25; "Purchase Performance")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Performance';
                }
                part(Control37; "Purchase Performance")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Caption = 'Purchase Performance';
                }
                part(Control21; "Inventory Performance")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Performance';
                }
                part(Control44; "Inventory Performance")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Caption = 'Inventory Performance';
                }
                part(Control1905989608; "My Items")
                {
                    ApplicationArea = All;
                    Caption = 'My Items';
                }
                systempart(Control43; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group("Procurement Reports")
            {
                action("Procurement Requests By Method - Detailed")
                {
                    RunObject = report "Procurement Requests By Method";
                    Image = Report;
                    ApplicationArea = All;
                }


                action("Procurement Requests By Method - Summarized")
                {
                    RunObject = report "Procurement By Method Summary";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("Overdue Invoices")
                {
                    Caption = 'Overdue Vendor Invoices';
                    RunObject = report "Overdue Vendor Invoices";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("Prequalified Suppliers")
                {
                    RunObject = report "Prequalified Suppliers";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("LPO Balances")
                {
                    RunObject = report "LPO Balances";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("LPO Processed by Month")
                {
                    RunObject = report "LPO Processed by Month";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("Invoice Payments")
                {
                    RunObject = report "Invoice Payments";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("LPO Discrepancies")
                {
                    RunObject = report "LPO Discrepancies";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("Canceled Approved LPO's")
                {
                    RunObject = report "Cancel Approved LPO";
                    Image = Report;
                    ApplicationArea = All;
                    Visible = false;
                }
                action("Tender Applicants")
                {
                    RunObject = report "Tender Applicants";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("All Payments")
                {
                    RunObject = report "All Payments";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("Bank Payments")
                {
                    RunObject = report "Bank Payments";
                    Image = Report;
                    ApplicationArea = All;
                }


            }
            group("Ch_proc Reports")
            {
                Caption = 'CH-Procument ManageMent';

                action("LPO Balances_ch")
                {
                    RunObject = report LPO;
                    Image = Report;
                    ApplicationArea = All;
                }
                action("REQUEST FOR QUOTATION_ch2")
                {
                    RunObject = report "REQUEST FOR QUOTATION";
                    Image = Report;
                    ApplicationArea = All;
                }
                action("cio_ch2")
                {
                    RunObject = report "Conflict of Interest(COI)";
                    Image = Report;
                    ApplicationArea = All;
                }



            }
            action("Vendor - T&op 10 List")
            {
                ApplicationArea = All;
                Caption = 'Vendor - T&op 10 List';
                Image = "Report";
                RunObject = report "Vendor - Top 10 List";
                ToolTip = 'View a list of the vendors from whom you purchase the most or to whom you owe the most.';
                Visible = false;
            }
            action("Vendor/&Item Purchases")
            {
                ApplicationArea = All;
                Caption = 'Vendor/&Item Purchases';
                Image = "Report";
                RunObject = report "Vendor/Item Purchases";
                ToolTip = 'View a list of item entries for each vendor in a selected period.';
                Visible = false;
            }
            action("Global Budget")
            {
                ApplicationArea = All;
                Caption = 'Global Budget';
                Image = "Report";
                RunObject = page "G/L Budget Names";
                ToolTip = 'View a G/L Account List';
            }
            separator(Action28)
            {
            }
            action("Inventory - &Availability Plan")
            {
                ApplicationArea = All;
                Caption = 'Inventory - &Availability Plan';
                Image = ItemAvailability;
                RunObject = report "Inventory - Availability Plan";
                ToolTip = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.';
                Visible = false;
            }
            action("Inventory &Purchase Orders")
            {
                ApplicationArea = All;
                Caption = 'Inventory &Purchase Orders';
                Image = "Report";
                RunObject = report "Inventory Purchase Orders";
                ToolTip = 'View a list of items on order from vendors. The report also shows the expected receipt date and the quantity and amount on back orders. The report can be used, for example, to see when items should be received and whether a reminder of a back order should be issued.';
                Visible = false;
            }
            action("Inventory - &Vendor Purchases")
            {
                ApplicationArea = All;
                Caption = 'Inventory - &Vendor Purchases';
                Image = "Report";
                RunObject = report "Inventory - Vendor Purchases";
                ToolTip = 'View a list of the vendors that your company has purchased items from within a selected period. It shows invoiced quantity, amount and discount. The report can be used to analyze a company''s item purchases.';
                Visible = false;
            }
            action("Inventory &Cost and Price List")
            {
                ApplicationArea = All;
                Caption = 'Inventory &Cost and Price List';
                Image = "Report";
                RunObject = report "Inventory Cost and Price List";
                Visible = false;
                ToolTip = 'View price information for your items or stockkeeping units, such as direct unit cost, last direct cost, unit price, profit percentage, and profit.';
            }
        }
        area(embedding)
        {
            action(PurchaseOrders)
            {
                ApplicationArea = All;
                Caption = 'Open Purchase Orders';
                RunObject = page "Purchase Order List";
                ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action(PurchaseOrdersPendConf)
            {
                ApplicationArea = All;
                Caption = 'Pending Confirmation';
                RunObject = page "Purchase Order List";
                RunPageView = where(Status = filter(Open));
                ToolTip = 'View the list of purchase orders that await the vendor''s confirmation. ';
            }
            action(PurchaseOrdersPartDeliv)
            {
                ApplicationArea = All;
                Caption = 'Partially Delivered';
                RunObject = page "Purchase Order List";
                RunPageView = where(Status = filter(Released),
                                    Receive = filter(true),
                                    "Completely Received" = filter(false));
                ToolTip = 'View the list of purchases that are partially received.';
            }
            action("Purchase Quotes")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase Quotes';
                RunObject = page "Purchase Quotes";
                ToolTip = 'Create purchase quotes to represent your request for quotes from vendors. Quotes can be converted to purchase orders.';
            }

            action("Event")
            {
                Image = "Order";
                RunObject = page "EventsList.Page";
                //RunPageLink = Status = filter(<> Released);
                ApplicationArea = All;
                ToolTip = 'Executes the Events list  action';
                Caption = 'Events';
            }
            action("Blanket Purchase Orders")
            {
                ApplicationArea = Suite;
                Caption = 'Blanket Purchase Orders';
                RunObject = page "Blanket Purchase Orders";
                ToolTip = 'Use blanket purchase orders as a framework for a long-term agreement between you and your vendors to buy large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a purchase order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes..';
            }
            action("Purchase Invoice")
            {
                ApplicationArea = All;
                Caption = 'Purchase Invoices';
                RunObject = page "Purchase Invoices";
                ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action("Purchase Return Orders")
            {
                ApplicationArea = PurchReturnOrder;
                Caption = 'Purchase Return Orders';
                RunObject = page "Purchase Return Order List";
                ToolTip = 'Create purchase return orders to mirror sales return documents that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. Purchase return orders enable you to ship back items from multiple purchase documents with one purchase return and support warehouse documents for the item handling. Purchase return orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
            }
            action("Purchase Credit Memo")
            {
                ApplicationArea = All;
                Caption = 'Purchase Credit Memos';
                RunObject = page "Purchase Credit Memos";
                ToolTip = 'Create purchase credit memos to mirror sales credit memos that vendors send to you for incorrect or damaged items that you have paid for and then returned to the vendor. If you need more control of the purchase return process, such as warehouse documents for the physical handling, use purchase return orders, in which purchase credit memos are integrated. Purchase credit memos can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature. Note: If you have not yet paid for an erroneous purchase, you can simply cancel the posted purchase invoice to automatically revert the financial transaction.';
            }
            action("Assembly Orders")
            {
                ApplicationArea = Assembly;
                Caption = 'Assembly Orders';
                RunObject = page "Assembly Orders";
                ToolTip = 'View ongoing assembly orders.';
            }
            action("Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = page "Sales Order List";
                ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
            }
            action(Vendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = page "Vendor List";
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }
            action(Item)
            {
                ApplicationArea = All;
                Caption = 'Items';
                Image = Item;
                RunObject = page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action("Catalog Items")
            {
                ApplicationArea = All;
                Caption = 'Catalog Items';
                Image = NonStockItem;
                RunObject = page "Catalog Item List";
                ToolTip = 'View the list of items that you do not carry in inventory. ';
            }
            action("Stockkeeping Unit")
            {
                ApplicationArea = Warehouse;
                Caption = 'Stockkeeping Units';
                Image = SKU;
                RunObject = page "Stockkeeping Unit List";
                ToolTip = 'Open the list of item SKUs to view or edit instances of item at different locations or with different variants. ';
            }
            action("Purchase Analysis Reports")
            {
                ApplicationArea = All;
                Caption = 'Purchase Analysis Reports';
                RunObject = page "Analysis Report Purchase";
                RunPageView = where("Analysis Area" = filter(Purchase));
                ToolTip = 'Analyze the dynamics of your purchase volumes. You can also use the report to analyze your vendors'' performance and purchase prices.';
            }
            action("Inventory Analysis Reports")
            {
                ApplicationArea = All;
                Caption = 'Inventory Analysis Reports';
                RunObject = page "Analysis Report Inventory";
                RunPageView = where("Analysis Area" = filter(Inventory));
                ToolTip = 'Analyze the dynamics of your inventory according to key performance indicators that you select, for example inventory turnover. You can also use the report to analyze your inventory costs, in terms of direct and indirect costs, as well as the value and quantities of your different types of inventory.';
            }
            action("Item Journals")
            {
                ApplicationArea = All;
                Caption = 'Item Journals';
                RunObject = page "Item Journal Batches";
                RunPageView = where("Template Type" = const(Item),
                                    Recurring = const(false));
                ToolTip = 'Post item transactions directly to the item ledger to adjust inventory in connection with purchases, sales, and positive or negative adjustments without using documents. You can save sets of item journal lines as standard journals so that you can perform recurring postings quickly. A condensed version of the item journal function exists on item cards for quick adjustment of an items inventory quantity.';
            }
            action("Purchase Journals ")
            {
                ApplicationArea = All;
                Caption = 'Purchase Journals';
                RunObject = page "General Journal Batches";
                RunPageView = where("Template Type" = const(Purchases),
                                    Recurring = const(false));
                ToolTip = 'Post any purchase-related transaction directly to a vendor, bank, or general ledger account instead of using dedicated documents. You can post all types of financial purchase transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a purchase journal.';
            }
            action(RequisitionWorksheets)
            {
                ApplicationArea = Planning;
                Caption = 'Requisition Worksheets';
                RunObject = page "Req. Wksh. Names";
                RunPageView = where("Template Type" = const("Req."),
                                    Recurring = const(false));
                ToolTip = 'Calculate a supply plan to fulfill item demand with purchases or transfers.';
            }
            action(SubcontractingWorksheets)
            {
                ApplicationArea = Planning;
                Caption = 'Subcontracting Worksheets';
                RunObject = page "Req. Wksh. Names";
                RunPageView = where("Template Type" = const("For. Labor"),
                                    Recurring = const(false));
                ToolTip = 'Calculate the needed production supply, find the production orders that have material ready to send to a subcontractor, and automatically create purchase orders for subcontracted operations from production order routings.';
            }
            action("Standard Cost Worksheets")
            {
                ApplicationArea = All;
                Caption = 'Standard Cost Worksheets';
                RunObject = page "Standard Cost Worksheet Names";
                ToolTip = 'Review or update standard costs. Purchasers, production or assembly managers can use the worksheet to simulate the effect on the cost of the manufactured or assembled item if the standard cost for consumption, production capacity usage, or assembly resource usage is changed. You can set a cost change to take effect on a specified date.';
            }
        }
        area(creation)
        {
            action("Purchase &Quote")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase &Quote';
                Image = Quote;
                RunObject = page "Purchase Quote";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase quote, for example to reflect a request for quote.';
            }
            action("Purchase &Order")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase &Order';
                Image = Document;
                RunObject = page "Purchase Order";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase order.';
            }
            action("Purchase &Invoice")
            {
                ApplicationArea = All;
                Caption = 'Purchase &Invoice';
                Image = NewPurchaseInvoice;
                RunObject = page "Purchase Invoice";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase invoice.';
            }
            action("Purchase &Return Order")
            {
                ApplicationArea = PurchReturnOrder;
                Caption = 'Purchase &Return Order';
                Image = ReturnOrder;
                RunObject = page "Purchase Return Order";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase return order to return received items.';
                Visible = false;
            }

            action("Events")
            {
                ApplicationArea = Suite;
                Caption = 'Events';
                Image = Quote;
                RunObject = page "Events.Page";
                RunPageMode = Create;
                ToolTip = 'Create a new events, for procurement Planning';
                Visible = false;
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("&Purchase Journal")
            {
                ApplicationArea = All;
                Caption = '&Purchase Journal';
                Image = Journals;
                RunObject = page "Purchase Journal";
                ToolTip = 'Post purchase transactions directly to the general ledger. The purchase journal may already contain journal lines that are created as a result of related functions.';
            }
            action("Item &Journal")
            {
                ApplicationArea = All;
                Caption = 'Item &Journal';
                Image = Journals;
                RunObject = page "Item Journal";
                ToolTip = 'Adjust the physical quantity of items on inventory.';
                Visible = false;
            }
            action("Order Plan&ning")
            {
                ApplicationArea = Planning;
                Caption = 'Order Plan&ning';
                Image = Planning;
                RunObject = page "Order Planning";
                ToolTip = 'Plan supply orders order by order to fulfill new demand.';
                Visible = false;
            }
            separator(Action38)
            {
            }
            action("Requisition &Worksheet")
            {
                ApplicationArea = Planning;
                Caption = 'Requisition &Worksheet';
                Image = Worksheet;
                RunObject = page "Req. Wksh. Names";
                RunPageView = where("Template Type" = const("Req."),
                                    Recurring = const(false));
                ToolTip = 'Calculate a supply plan to fulfill item demand with purchases or transfers.';
                Visible = false;
            }
            action("Pur&chase Prices")
            {
                ApplicationArea = All;
                Caption = 'Pur&chase Prices';
                Image = Price;
                //RunObject = page "Purchase Prices";
                ToolTip = 'View or set up different prices for items that you buy from the vendor. An item price is automatically granted on invoice lines when the specified criteria are met, such as vendor, quantity, or ending date.';
                Visible = false;
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                ApplicationArea = All;
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = page Navigate;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                Visible = false;
            }
        }
        area(sections)
        {
            group("Contract Management")
            {
                Caption = 'Contract Management';
                action("Procurement Contracts")
                {
                    RunObject = page "Procurement Contracts";
                    ApplicationArea = All;
                    Caption = 'New Contracts';
                    ToolTip = 'Displays New Procurement Contracts';
                    RunPageLink = "Contract Status" = const(New);
                }
                action("Procurement Contracts-Active")
                {
                    RunObject = page "Procurement Contracts";
                    ApplicationArea = All;
                    Caption = 'Active Contracts';
                    ToolTip = 'Displays Active Procurement Contracts';
                    RunPageLink = "Contract Status" = const(Active);
                }
                action("Procurement Contracts-Terminated")
                {
                    RunObject = page "Procurement Contracts";
                    ApplicationArea = All;
                    Caption = 'Terminated Contracts';
                    ToolTip = 'Displays Terminated Procurement Contracts';
                    RunPageLink = "Contract Status" = const(Terminated);
                }
                group(ContractReports)
                {
                    Caption = 'Contract Reports';

                    action(Contracts)
                    {
                        RunObject = report "Procurement Contracts";
                        ApplicationArea = All;
                        Caption = 'Procurement Contracts';
                        ToolTip = 'Displays Procurement Contracts';
                    }
                }
            }
            group("EOI")
            {
                Caption = 'EOI';
                action("EOI List")
                {
                    Image = List;
                    RunObject = page "EOI List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the EOI List action';
                    Caption = 'EOI List';
                }
                action("EOI Archive list")
                {
                    Image = List;
                    RunObject = page "EOI Archive List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the EOI Archive list action';
                    Caption = 'EOI Archive list';
                }
                group("EOI Evaluation")
                {
                    Caption = 'EOI Evaluation';
                    Visible = false;

                    action("EOI evaluation list")
                    {
                        Image = List;
                        RunObject = page "EOI Evaluation List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the EOI evaluation list action';
                        Caption = 'EOI evaluation list';
                    }
                    action("EOI evaluation archive list")
                    {
                        Image = List;
                        RunObject = page "EOI EvaluationArchiveList";
                        ApplicationArea = All;
                        ToolTip = 'Executes the EOI evaluation archive list action';
                        Caption = 'EOI evaluation archive list';
                    }
                }
            }
            group("Group42")
            {
                Caption = 'Fixed Assets';
                action("Fixed Assets12")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    RunObject = page "Fixed Asset List";
                    ToolTip = 'Executes the Fixed Assets action';
                }
                action("Insurance12")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance';
                    RunObject = page "Insurance List";
                    ToolTip = 'Executes the Insurance action';
                }
                action("Calculate Depreciation...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Calculate Depreciation...';
                    RunObject = report "Calculate Depreciation";
                    ToolTip = 'Executes the Calculate Depreciation... action';
                }
                action("Fixed Assets...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Index Fixed Assets...';
                    RunObject = report "Index Fixed Assets";
                    ToolTip = 'Executes the Index Fixed Assets... action';
                }
                action("Insurance...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Index Insurance...';
                    RunObject = report "Index Insurance";
                    ToolTip = 'Executes the Index Insurance... action';
                }
                group("Group43")
                {
                    Caption = 'Journals';

                    action("G/L Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA G/L Journals';
                        RunObject = page "Fixed Asset G/L Journal";
                        ToolTip = 'Executes the FA G/L Journals action';
                    }
                    action("FA Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Journals';
                        RunObject = page "Fixed Asset Journal";
                        ToolTip = 'Executes the FA Journals action';
                    }
                    action("FA Reclass. Journal")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Reclassification Journals';
                        RunObject = page "FA Reclass. Journal";
                        ToolTip = 'Executes the FA Reclassification Journals action';
                    }
                    action("Insurance Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Journals';
                        RunObject = page "Insurance Journal";
                        ToolTip = 'Executes the Insurance Journals action';
                    }
                    action("Recurring Journals1")
                    {
                        ApplicationArea = Suite, FixedAssets;
                        Caption = 'Recurring General Journals';
                        RunObject = page "Recurring General Journal";
                        ToolTip = 'Executes the Recurring General Journals action';
                    }
                    action("Recurring Fixed Asset Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Recurring Fixed Asset Journals';
                        RunObject = page "Recurring Fixed Asset Journal";
                        ToolTip = 'Executes the Recurring Fixed Asset Journals action';
                    }
                }
                group("Group44")
                {
                    Caption = 'Reports';

                    group("Group45")
                    {
                        Caption = 'Fixed Assets';

                        action("Posting Group - Net Change")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Posting Group - Net Change';
                            RunObject = report "FA Posting Group - Net Change";
                            ToolTip = 'Executes the FA Posting Group - Net Change action';
                        }
                        action("Register1")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Register';
                            RunObject = report "Fixed Asset Register";
                            ToolTip = 'Executes the FA Register action';
                        }
                        action("Acquisition List")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Acquisition List';
                            RunObject = report "Fixed Asset - Acquisition List";
                            ToolTip = 'Executes the FA Acquisition List action';
                        }
                        action("Analysis1")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Analysis';
                            RunObject = report "Fixed Asset - Analysis";
                            ToolTip = 'Executes the FA Analysis action';
                        }
                        action("Book Value 01")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Book Value 01';
                            RunObject = report "Fixed Asset - Book Value 01";
                            ToolTip = 'Executes the FA Book Value 01 action';
                        }
                        action("Book Value 02")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Book Value 02';
                            RunObject = report "Fixed Asset - Book Value 02";
                            ToolTip = 'Executes the FA Book Value 02 action';
                        }
                        action("Details")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Details';
                            RunObject = report "Fixed Asset - Details";
                            ToolTip = 'Executes the FA Details action';
                        }
                        action("G/L Analysis")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA G/L Analysis';
                            RunObject = report "Fixed Asset - G/L Analysis";
                            ToolTip = 'Executes the FA G/L Analysis action';
                        }
                        action("List1")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA List';
                            RunObject = report "Fixed Asset - List";
                            ToolTip = 'Executes the FA List action';
                        }
                        action("Projected Value")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Projected Value';
                            RunObject = report "Fixed Asset - Projected Value";
                            ToolTip = 'Executes the FA Projected Value action';
                        }
                    }
                    group("Group46")
                    {
                        Caption = 'Insurance';

                        action("Uninsured FAs")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Uninsured FAs';
                            RunObject = report "Insurance - Uninsured FAs";
                            ToolTip = 'Executes the Uninsured FAs action';
                        }
                        action("Register2")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance Register';
                            RunObject = report "Insurance Register";
                            ToolTip = 'Executes the Insurance Register action';
                        }
                        action("Analysis2")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance Analysis';
                            RunObject = report "Insurance - Analysis";
                            ToolTip = 'Executes the Insurance Analysis action';
                        }
                        action("Coverage Details")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance Coverage Details';
                            RunObject = report "Insurance - Coverage Details";
                            ToolTip = 'Executes the Insurance Coverage Details action';
                        }
                        action("List2")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance List';
                            RunObject = report "Insurance - List";
                            ToolTip = 'Executes the Insurance List action';
                        }
                        action("Tot. Value Insured")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Total Value Insured';
                            RunObject = report "Insurance - Tot. Value Insured";
                            ToolTip = 'Executes the FA Total Value Insured action';
                        }
                    }
                    group("Group47")
                    {
                        Caption = 'Maintenance';

                        action("Register3")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Register';
                            RunObject = report "Maintenance Register";
                            ToolTip = 'Executes the Maintenance Register action';
                        }
                        action("Analysis3")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Analysis';
                            RunObject = report "Maintenance - Analysis";
                            ToolTip = 'Executes the Maintenance Analysis action';
                        }
                        action("Details1")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Details';
                            RunObject = report "Maintenance - Details";
                            ToolTip = 'Executes the Maintenance Details action';
                        }
                        action("Next Service")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Next Service';
                            RunObject = report "Maintenance - Next Service";
                            ToolTip = 'Executes the Maintenance Next Service action';
                        }
                    }
                }
                group("Group48")
                {
                    Caption = 'Registers/Entries';

                    action("FA Registers12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Registers';
                        RunObject = page "FA Registers";
                        ToolTip = 'Executes the FA Registers action';
                    }
                    action("Insurance Registers12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Registers';
                        RunObject = page "Insurance Registers";
                        ToolTip = 'Executes the Insurance Registers action';
                    }
                    action("FA Ledger Entries12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Ledger Entries';
                        RunObject = page "FA Ledger Entries";
                        ToolTip = 'Executes the FA Ledger Entries action';
                    }
                    action("Maintenance Ledger Entries12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Maintenance Ledger Entries';
                        RunObject = page "Maintenance Ledger Entries";
                        ToolTip = 'Executes the Maintenance Ledger Entries action';
                    }
                    action("Ins. Coverage Ledger Entries12")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Coverage Ledger Entries';
                        RunObject = page "Ins. Coverage Ledger Entries";
                        ToolTip = 'Executes the Insurance Coverage Ledger Entries action';
                    }
                }
                group("Group49")
                {
                    Caption = 'Setup';

                    action("FA Setup")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Setup';
                        RunObject = page "Fixed Asset Setup";
                        ToolTip = 'Executes the FA Setup action';
                    }
                    action("FA Classes")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Classes';
                        RunObject = page "FA Classes";
                        ToolTip = 'Executes the FA Classes action';
                    }
                    action("FA Subclasses")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Subclasses';
                        RunObject = page "FA Subclasses";
                        ToolTip = 'Executes the FA Subclasses action';
                    }
                    action("FA Locations")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Locations';
                        RunObject = page "FA Locations";
                        ToolTip = 'Executes the FA Locations action';
                    }
                    action("Insurance Types")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Types';
                        RunObject = page "Insurance Types";
                        ToolTip = 'Executes the Insurance Types action';
                    }
                    action("Maintenance")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Maintenance';
                        RunObject = page "Maintenance";
                        ToolTip = 'Executes the Maintenance action';
                    }
                    action("Depreciation Books")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Depreciation Books';
                        RunObject = page "Depreciation Book List";
                        ToolTip = 'Executes the Depreciation Books action';
                    }
                    action("Depreciation Tables")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Depreciation Tables';
                        RunObject = page "Depreciation Table List";
                        ToolTip = 'Executes the Depreciation Tables action';
                    }
                    action("FA Journal Templates")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Journal Templates';
                        RunObject = page "FA Journal Templates";
                        ToolTip = 'Executes the FA Journal Templates action';
                    }
                    action("FA Reclass. Journal Templates")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Reclassification Journal Template';
                        RunObject = page "FA Reclass. Journal Templates";
                        ToolTip = 'Executes the FA Reclassification Journal Template action';
                    }
                    action("Insurance Journal Templates")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Journal Templates';
                        RunObject = page "Insurance Journal Templates";
                        ToolTip = 'Executes the Insurance Journal Templates action';
                    }
                }
            }
            group("Fixed Asset Disposal")
            {
                Caption = 'Fixed Asset Disposal';
                group("Mark Asset For Disposal")
                {
                    action("FA Disposal")
                    {
                        Image = Bin;
                        RunObject = page "FA Disposal List";
                        RunPageLink = Status = filter(<> Approved);
                        ApplicationArea = All;
                        ToolTip = 'Executes the FA Disposal action';
                        Caption = 'FA Disposal';
                    }
                    action("FA Disposal-Approved")
                    {
                        Image = Bin;
                        RunObject = page "FA Disposal List";
                        RunPageLink = Status = const(Approved), Fullfilled = const(false);
                        ApplicationArea = All;
                        ToolTip = 'Executes the FA Disposal-Approved action';
                        Caption = 'FA Disposal-Approved';
                    }
                    action("FA Disposal-Fullfilled")
                    {
                        Image = Bin;
                        RunObject = page "FA Disposal List";
                        RunPageLink = Status = const(Approved), Fullfilled = const(true);
                        ApplicationArea = All;
                        ToolTip = 'Executes the FA Disposal-Fullfilled action';
                        Caption = 'FA Disposal-Fullfilled';
                    }
                    action("Fixed Assets Marked For Disposal")
                    {
                        Image = Bin;
                        RunObject = page "FA Marked For Disposal List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Fixed Assets Marked For Disposal action';
                        Caption = 'Fixed Assets Marked For Disposal';
                    }
                }
                group("FA Disposal Quotation")
                {
                    Caption = 'FA Disposal Quotation';
                    action("FA Disposal Quote")
                    {
                        Image = List;
                        RunObject = page "FA Disposal Quote List";
                        RunPageLink = Status = filter(<> Approved);
                        ApplicationArea = All;
                        ToolTip = 'Executes the FA Disposal Quote action';
                        Caption = 'FA Disposal Quote';
                    }
                    action("FA Disposal Quote-Submitted")
                    {
                        Image = List;
                        RunObject = page "FA Disposal Quote List";
                        RunPageLink = Status = const(Approved);
                        ApplicationArea = All;
                        ToolTip = 'Executes the FA Disposal Quote-Submitted action';
                        Caption = 'FA Disposal Quote-Submitted';
                    }
                }
            }
            group("Inventory")
            {
                Caption = 'Inventory';
                group("Items ")
                {
                    Caption = 'Items ';
                    action(Items)
                    {
                        Caption = 'Item List';
                        RunObject = page "Item List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Items action';
                    }
                    action("Nonstock Items")
                    {
                        RunObject = page "Catalog Item List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Nonstock Items action';
                        Caption = 'Nonstock Items';
                    }
                    action("Stockkeeping Units")
                    {
                        RunObject = page "Stockkeeping Unit List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Stockkeeping Units action';
                        Caption = 'Stockkeeping Units';
                    }
                }
                group(ItemTransfer)
                {
                    Caption = 'Item Transfer';
                    action("Item Transfer List")
                    {
                        RunObject = page "Item Transfer List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Item Transfer List action';
                        Caption = 'Item Transfer List';
                    }
                }

                action("Inventory Periods12")
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Periods';
                    RunObject = page "Inventory Periods";
                    ToolTip = 'Executes the Inventory Periods action';
                }
                action("Phys. Invt. Counting Periods")
                {
                    ApplicationArea = Warehouse, Basic, Suite;
                    Caption = 'Physical Invtory Counting Periods';
                    RunObject = page "Phys. Invt. Counting Periods";
                    ToolTip = 'Executes the Physical Invtory Counting Periods action';
                }
                action("Application Worksheet")
                {
                    ApplicationArea = All;
                    Caption = 'Application Worksheet';
                    RunObject = page "Application Worksheet";
                    ToolTip = 'Executes the Application Worksheet action';
                }
                group("Group51")
                {
                    Caption = 'Costing';

                    action("Adjust Item Costs/Prices")
                    {
                        ApplicationArea = All;
                        Caption = 'Adjust Item Costs/Prices';
                        RunObject = report "Adjust Item Costs/Prices";
                        ToolTip = 'Executes the Adjust Item Costs/Prices action';
                    }
                    action("Adjust Cost - Item Entries")
                    {
                        ApplicationArea = All;
                        Caption = 'Adjust Cost - Item Entries...';
                        RunObject = report "Adjust Cost - Item Entries";
                        ToolTip = 'Executes the Adjust Cost - Item Entries... action';
                    }
                    action("Update Unit Cost...")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Update Unit Costs...';
                        RunObject = report "Update Unit Cost";
                        ToolTip = 'Executes the Update Unit Costs... action';
                    }
                    action("Post Inventory Cost to G/L")
                    {
                        ApplicationArea = All;
                        Caption = 'Post Inventory Cost to G/L';
                        RunObject = report "Post Inventory Cost to G/L";
                        ToolTip = 'Executes the Post Inventory Cost to G/L action';
                    }
                }
                group("Group52")
                {
                    Caption = 'Journals';

                    action("Item Journal")
                    {
                        ApplicationArea = All;
                        Caption = 'Item Journals';
                        RunObject = page "Item Journal";
                        ToolTip = 'Executes the Item Journals action';
                    }
                    action("Item Reclass. Journals")
                    {
                        ApplicationArea = All;
                        Caption = 'Item Reclassification Journals';
                        RunObject = page "Item Reclass. Journal";
                        ToolTip = 'Executes the Item Reclassification Journals action';
                    }
                    action("Phys. Inventory Journals")
                    {
                        ApplicationArea = All;
                        Caption = 'Physical Inventory Journals';
                        RunObject = page "Phys. Inventory Journal";
                        ToolTip = 'Executes the Physical Inventory Journals action';
                    }
                    action("Revaluation Journals")
                    {
                        ApplicationArea = All;
                        Caption = 'Revaluation Journals';
                        RunObject = page "Revaluation Journal";
                        ToolTip = 'Executes the Revaluation Journals action';
                    }
                }
                group("Group53")
                {
                    Caption = 'Reports';

                    action("Inventory Valuation")
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory Valuation';
                        RunObject = report "Inventory Valuation";
                        ToolTip = 'Executes the Inventory Valuation action';
                    }
                    action("Inventory Valuation - WIP")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Production Order - WIP';
                        RunObject = report "Inventory Valuation - WIP";
                        ToolTip = 'Executes the Production Order - WIP action';
                    }
                    action("Inventory - List")
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory - List';
                        RunObject = report "Inventory - List";
                        ToolTip = 'Executes the Inventory - List action';
                    }
                    action("Invt. Valuation - Cost Spec.")
                    {
                        ApplicationArea = All;
                        Caption = 'Invt. Valuation - Cost Spec.';
                        RunObject = report "Invt. Valuation - Cost Spec.";
                        ToolTip = 'Executes the Invt. Valuation - Cost Spec. action';
                    }
                    action("Item Age Composition - Value")
                    {
                        ApplicationArea = All;
                        Caption = 'Item Age Composition - Value';
                        RunObject = report "Item Age Composition - Value";
                        ToolTip = 'Executes the Item Age Composition - Value action';
                    }
                    action("Item Register - Value")
                    {
                        ApplicationArea = All;
                        Caption = 'Item Register - Value';
                        RunObject = report "Item Register - Value";
                        ToolTip = 'Executes the Item Register - Value action';
                    }
                    action("Physical Inventory List")
                    {
                        ApplicationArea = Warehouse;
                        Caption = 'Physical Inventory List';
                        RunObject = report "Phys. Inventory List";
                        ToolTip = 'Executes the Physical Inventory List action';
                    }
                    action("Status")
                    {
                        ApplicationArea = All;
                        Caption = 'Status';
                        RunObject = report "Status";
                        ToolTip = 'Executes the Status action';
                    }
                    action("Cost Shares Breakdown")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Cost Shares Breakdown';
                        RunObject = report "Cost Shares Breakdown";
                        ToolTip = 'Executes the Cost Shares Breakdown action';
                    }
                    action("Item Register - Quantity")
                    {
                        ApplicationArea = All;
                        Caption = 'Item Register - Quantity';
                        RunObject = report "Item Register - Quantity";
                        ToolTip = 'Executes the Item Register - Quantity action';
                    }
                    action("Item Dimensions - Detail")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Item Dimensions - Detail';
                        RunObject = report "Item Dimensions - Detail";
                        ToolTip = 'Executes the Item Dimensions - Detail action';
                    }
                    action("Item Dimensions - Total")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Item Dimensions - Total';
                        RunObject = report "Item Dimensions - Total";
                        ToolTip = 'Executes the Item Dimensions - Total action';
                    }
                    action("Inventory - G/L Reconciliation")
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory - G/L Reconciliation';
                        RunObject = page "Inventory - G/L Reconciliation";
                        ToolTip = 'Executes the Inventory - G/L Reconciliation action';
                    }
                }
                group("Group54")
                {
                    Caption = 'Setup';

                    action("Inventory Posting Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory Posting Setup';
                        RunObject = page "Inventory Posting Setup";
                        ToolTip = 'Executes the Inventory Posting Setup action';
                    }
                    action("Inventory Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory Setup';
                        RunObject = page "Inventory Setup";
                        ToolTip = 'Executes the Inventory Setup action';
                    }
                    action("Item Charges")
                    {
                        ApplicationArea = ItemCharges;
                        Caption = 'Item Charges';
                        RunObject = page "Item Charges";
                        ToolTip = 'Executes the Item Charges action';
                    }
                    action("Item Categories")
                    {
                        ApplicationArea = All;
                        Caption = 'Item Categories';
                        RunObject = page "Item Categories";
                        ToolTip = 'Executes the Item Categories action';
                    }
                    action("Rounding Methods")
                    {
                        ApplicationArea = All;
                        Caption = 'Rounding Methods';
                        RunObject = page "Rounding Methods";
                        AccessByPermission = tabledata Resource = R;
                        ToolTip = 'Executes the Rounding Methods action';
                    }
                    action("Analysis Types")
                    {
                        ApplicationArea = SalesAnalysis, PurchaseAnalysis, InventoryAnalysis;
                        Caption = 'Analysis Types';
                        RunObject = page "Analysis Types";
                        ToolTip = 'Executes the Analysis Types action';
                    }
                    action("Inventory Analysis Report")
                    {
                        ApplicationArea = InventoryAnalysis;
                        Caption = 'Inventory Analysis Reports';
                        RunObject = page "Analysis Report Inventory";
                        ToolTip = 'Executes the Inventory Analysis Reports action';
                    }
                    action("Analysis View Card")
                    {
                        ApplicationArea = InventoryAnalysis, Dimensions;
                        Caption = 'Inventory Analysis by Dimensions';
                        RunObject = page "Analysis View List Inventory";
                        ToolTip = 'Executes the Inventory Analysis by Dimensions action';
                    }
                    action("Analysis Column Templates")
                    {
                        ApplicationArea = InventoryAnalysis;
                        Caption = 'Invt. Analysis Column Templates';
                        RunObject = report "Run Invt. Analysis Col. Temp.";
                        ToolTip = 'Executes the Invt. Analysis Column Templates action';
                    }
                    action("Analysis Line Templates")
                    {
                        ApplicationArea = InventoryAnalysis;
                        Caption = 'Invt. Analysis Line Templates';
                        RunObject = report "Run Invt. Analysis Line Temp.";
                        ToolTip = 'Executes the Invt. Analysis Line Templates action';
                    }
                }
                group("Inventory  Setup")
                {
                    Caption = 'Inventory  Setup';
                    action("Units of Measure")
                    {
                        RunObject = page "Units of Measure";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Units of Measure action';
                        Caption = 'Units of Measure';
                    }
                }
            }
            group("Order Processings")
            {
                Caption = 'Order Processing';

                action(Contacts)
                {
                    RunObject = page "Contact List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Contacts action';
                    Caption = 'Contacts';
                }
                action("Purchase quotes ")
                {
                    RunObject = page "Purchase Quotes";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Purchase quote  action';
                    Caption = 'Purchase Quotes ';
                }
                group("Purchase Orders ")
                {
                    action("Open Purchase Orders")
                    {
                        Image = "Order";
                        RunObject = page "Purchase Order List";
                        RunPageLink = Status = const("Open");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Purchase Orders action';
                        Caption = 'Open Purchase Orders';
                    }
                    action("Purchase Order- Pending")
                    {
                        RunObject = page "Purchase Order List";
                        RunPageLink = Status = const("Pending Approval");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Purchase Order- Released action';
                        Caption = 'Pending Purchase Orders';
                    }
                    action("Purchase Order- Released")
                    {
                        RunObject = page "Purchase Order List";
                        RunPageLink = Status = const(Released);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Purchase Order- Released action';
                        Caption = 'Approved Purchase Orders';
                    }
                    action("Purchase Order- Archived")
                    {
                        RunObject = page "Purchase Order List";
                        RunPageLink = Status = const(Archived);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Purchase Order- Released action';
                        Caption = 'Archived Purchase Orders';
                    }
                    action("Purchase Order- Cancelled")
                    {
                        RunObject = page "Purchase Order List";
                        RunPageLink = Status = const(Cancelled);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Purchase Order- Released action';
                        Caption = 'Cancelled Purchase Orders';
                    }
                    action("Purchase Order- Posted")
                    {
                        RunObject = page "Posted Purchase Orders";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Purchase Order- Released action';
                        Caption = 'Posted Purchase Orders';
                    }
                }
                action("Purchase Invoices")
                {
                    RunObject = page "Purchase Invoices";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Purchase Invoices action';
                    Caption = 'Purchase Invoices';
                }
                action("Purchase Credit Memos")
                {
                    RunObject = page "Purchase Credit Memos";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Purchase Credit Memos action';
                    Caption = 'Purchase Credit Memos';
                }
                action("Purchase Return Orders ")
                {
                    RunObject = page "Purchase Return Orders";
                    ApplicationArea = All;
                }
                action("Event2")
                {
                    Image = "Order";
                    RunObject = page "EventsList.Page";
                    //RunPageLink = Status = filter(<> Released);
                    ApplicationArea = All;
                    ToolTip = 'Executes the Events list  action';
                    Caption = 'Events';
                }
            }
            group("Payables")
            {
                Caption = 'Payables';

                action("Vendors12")
                {
                    ApplicationArea = All;
                    Caption = 'Vendors';
                    RunObject = page "Vendor List";
                    RunPageLink = "Vendor Type" = filter(<> "Share holder");
                    ToolTip = 'Executes the Vendors action';
                }
                group("Vendor Evaluation")
                {
                    Caption = 'Vendor Evaluation';
                    action("Vendor Evaluation List")
                    {
                        ApplicationArea = All;
                        RunObject = page "Vendor Evaluation List";
                        RunPageLink = Status = const(New);
                        ToolTip = 'Executes the Vendor Evaluation List action';
                        Caption = 'Vendor Evaluation List';
                    }
                    action("Pending Vendor Evaluation List")
                    {
                        ApplicationArea = All;
                        RunObject = page "Vendor Evaluation List";
                        RunPageLink = Status = const("Pending Approval");
                        ToolTip = 'Executes the Pending Vendor Evaluation List action';
                        Caption = 'Pending Vendor Evaluation List';
                    }
                    action("Approved Vendor Evaluation List")
                    {
                        ApplicationArea = All;
                        RunObject = page "Vendor Evaluation List";
                        RunPageLink = Status = const(Approved);
                        ToolTip = 'Executes the Approved Vendor Evaluation List action';
                        Caption = 'Approved Vendor Evaluation List';
                    }
                    action("Vendor Evaluation Setup")
                    {
                        ApplicationArea = All;
                        RunObject = page "Vendor Evaluation Setup";
                        ToolTip = 'Executes the Vendor Evaluation Setup action';
                        Caption = 'Vendor Evaluation Setup';
                    }
                    action("Vendor Evaluation Periods")
                    {
                        ApplicationArea = All;
                        RunObject = page "Vendor Evaluation Periods";
                        ToolTip = 'Executes the Vendor Evaluation Periods action';
                        Caption = 'Vendor Evaluation Periods';
                    }
                }
                action("Vendors13")
                {
                    ApplicationArea = All;
                    Caption = 'Share Holders';
                    RunObject = page "Vendor List";
                    RunPageLink = "Vendor Type" = filter("Share holder");
                    ToolTip = 'Executes the Share Holders action';
                }
                action("Invoices1")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Invoices';
                    RunObject = page "Purchase Invoices";
                    ToolTip = 'Executes the Purchase Invoices action';
                }
                action("Credit Memos1")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Credit Memos';
                    RunObject = page "Purchase Credit Memos";
                    ToolTip = 'Executes the Purchase Credit Memos action';
                }
                action("Incoming Documents")
                {
                    ApplicationArea = All;
                    Caption = 'Incoming Documents';
                    RunObject = page "Incoming Documents";
                    ToolTip = 'Executes the Incoming Documents action';
                }
                group("Group37")
                {
                    Caption = 'Journals';

                    action("Purchase Journals")
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase Journals';
                        RunObject = page "Purchase Journal";
                        ToolTip = 'Executes the Purchase Journals action';
                    }
                    action("Payment Journals1")
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Journals';
                        RunObject = page "Payment Journal";
                        ToolTip = 'Executes the Payment Journals action';
                    }
                }
                group("Group39")
                {
                    Caption = 'Registers/Entries';

                    action("G/L Registers2")
                    {
                        ApplicationArea = All;
                        Caption = 'G/L Registers';
                        RunObject = page "G/L Registers";
                        ToolTip = 'Executes the G/L Registers action';
                    }
                    action("Vendor Ledger Entries")
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor Ledger Entries';
                        RunObject = page "Vendor Ledger Entries";
                        ToolTip = 'Executes the Vendor Ledger Entries action';
                    }
                    action("Detailed Cust. Ledg. Entries1")
                    {
                        ApplicationArea = All;
                        Caption = 'Detailed Vendor Ledger Entries';
                        RunObject = page "Detailed Vendor Ledg. Entries";
                        ToolTip = 'Executes the Detailed Vendor Ledger Entries action';
                    }
                    action("Credit Transfer Registers")
                    {
                        ApplicationArea = All;
                        Caption = 'Credit Transfer Registers';
                        RunObject = page "Credit Transfer Registers";
                        ToolTip = 'Executes the Credit Transfer Registers action';
                    }
                    action("Employee Ledger Entries")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Employee Ledger Entries';
                        RunObject = page "Employee Ledger Entries";
                        ToolTip = 'Executes the Employee Ledger Entries action';
                    }
                }
                group("Group40")
                {
                    Caption = 'Reports';

                    action("Aged Accounts Payable")
                    {
                        ApplicationArea = All;
                        Caption = 'Aged Accounts Payable';
                        RunObject = report "Aged Accounts Payable";
                        ToolTip = 'Executes the Aged Accounts Payable action';
                    }
                    action("Payments on Hold")
                    {
                        ApplicationArea = All;
                        Caption = 'Payments on Hold';
                        RunObject = report "Payments on Hold";
                        ToolTip = 'Executes the Payments on Hold action';
                    }
                    action("Purchase Statistics")
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase Statistics';
                        RunObject = report "Purchase Statistics";
                        ToolTip = 'Executes the Purchase Statistics action';
                    }
                    action("Vendor Item Catalog")
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor Item Catalog';
                        RunObject = report "Vendor Item Catalog";
                        ToolTip = 'Executes the Vendor Item Catalog action';
                    }
                    action("Vendor Register")
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor Register';
                        RunObject = report "Vendor Register";
                        ToolTip = 'Executes the Vendor Register action';
                    }
                    action("Vendor - Balance to Date")
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor - Balance to Date';
                        RunObject = report "Vendor - Balance to Date";
                        ToolTip = 'Executes the Vendor - Balance to Date action';
                    }
                    action("Vendor - Detail Trial Balance")
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor - Detail Trial Balance';
                        RunObject = report "Vendor - Detail Trial Balance";
                        ToolTip = 'Executes the Vendor - Detail Trial Balance action';
                    }
                    action("Vendor - Labels")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Vendor - Labels';
                        RunObject = report "Vendor - Labels";
                        ToolTip = 'Executes the Vendor - Labels action';
                    }
                    action("Vendor - List")
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor - List';
                        RunObject = report "Vendor - List";
                        ToolTip = 'Executes the Vendor - List action';
                    }
                    action("Vendor - Order Detail")
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor - Order Detail';
                        RunObject = report "Vendor - Order Detail";
                        ToolTip = 'Executes the Vendor - Order Detail action';
                    }
                    action("Vendor - Order Summary")
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor - Order Summary';
                        RunObject = report "Vendor - Order Summary";
                        ToolTip = 'Executes the Vendor - Order Summary action';
                    }
                    action("Vendor - Purchase List")
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor - Purchase List';
                        RunObject = report "Vendor - Purchase List";
                        ToolTip = 'Executes the Vendor - Purchase List action';
                    }
                    action("Vendor - Summary Aging")
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor - Summary Aging';
                        RunObject = report "Vendor - Summary Aging";
                        ToolTip = 'Executes the Vendor - Summary Aging action';
                    }
                    action("Vendor - Top 10 List")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Vendor - Top 10 List';
                        RunObject = report "Vendor - Top 10 List";
                        ToolTip = 'Executes the Vendor - Top 10 List action';
                    }
                    action("Vendor - Trial Balance")
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor - Trial Balance';
                        RunObject = report "Vendor - Trial Balance";
                        ToolTip = 'Executes the Vendor - Trial Balance action';
                    }
                    action("Vendor/Item Purchases")
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor/Item Purchases';
                        RunObject = report "Vendor/Item Purchases";
                        ToolTip = 'Executes the Vendor/Item Purchases action';
                    }
                }
                group("Group41")
                {
                    Caption = 'Setup';

                    action("Purchases & Payables Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'Purchases & Payables Setup';
                        RunObject = page "Purchases & Payables Setup";
                        ToolTip = 'Executes the Purchases & Payables Setup action';
                    }
                }
            }
            group(Plannings)
            {
                Caption = 'Planning';
                group("Budgets")
                {
                    Caption = 'Budgets';
                    Visible = false;
                    action(Budgeting)
                    {
                        Image = CostBudget;
                        RunObject = page "G/L Budget Names";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Budgeting action';
                        Caption = 'Budgeting';
                    }
                    action("Budget Approval List")
                    {
                        RunObject = page "Budget Approval List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Budget Approval List action';
                        Caption = 'Budget Approval List';
                    }
                    action("Budget Transfer")
                    {
                        RunObject = page "Vote Transfers";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Budget Approval List action';
                        Caption = 'Budget Transfers';
                    }
                    action("Budget Transfer - Posted")
                    {
                        RunObject = page "Posted Vote Transfers";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Budget Approval List action';
                        Caption = 'Posted Budget Transfers';
                    }
                    group("Budget Reports")
                    {
                        Caption = 'Budget Reports';
                        action("Budget vs Commitments")
                        {
                            RunObject = report "Votebook Summary";
                            ApplicationArea = All;
                            ToolTip = 'Executes the Budget vs Commitments action';
                            Caption = 'Budget vs Commitments';
                        }
                        action("Budget Report")
                        {
                            RunObject = report Budget;
                            ApplicationArea = All;
                            ToolTip = 'Executes the Budget Report action';
                            Caption = 'Budget Report';
                        }
                    }
                }
                group("Procurement Plans")
                {
                    Caption = 'Procurement Plans';
                    action("Procurement Plan ")
                    {
                        Image = PriceWorksheet;
                        RunObject = page "Procurement Plans";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Procurement plans action';
                        Caption = 'Procurement Plans';
                        RunPageLink = Status = const(Open);
                    }
                    action("Procurement Plan Approved")
                    {
                        Image = PriceWorksheet;
                        RunObject = page "Procurement Plans";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Procurement plans action';
                        Caption = 'Procurement Plans - Approved';
                        RunPageLink = Status = const(Approved);
                    }
                    action("Procurement Plan Rejected")
                    {
                        Image = PriceWorksheet;
                        RunObject = page "Procurement Plans";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Procurement plans action';
                        Caption = 'Procurement Plans - Rejected';
                        RunPageLink = Status = const(Rejected);
                    }
                }
                group("Procurement Plan Request")
                {
                    Caption = 'Procurement Plan Requests';
                    action("Procurement Plan HOD Approval")
                    {
                        Image = PriceWorksheet;
                        RunObject = page "Procurement Plan Approvals";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Procurement Plan Approval action';
                        Caption = 'Plan Requests - Open';
                        RunPageLink = Status = const(Open);
                    }
                    action("Procurement Plan HOD Approval-Pending")
                    {
                        Image = PriceWorksheet;
                        RunObject = page "Procurement Plan Approvals";
                        RunPageMode = View;
                        RunPageLink = Status = const("Pending Approval");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Procurement Plan Approval action';
                        Caption = 'Plan Requests - Pending Approval';
                    }
                    action("Procurement Plan HOD Approved")
                    {
                        Image = PriceWorksheet;
                        RunObject = page "Procurement Plan Approved List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Procurement Plan Approved action';
                        Caption = 'Plan Requests - Approved';
                    }
                    action("Procurement Plan HOD Approval-Rejected")
                    {
                        Image = PriceWorksheet;
                        RunObject = page "Procurement Plan Approvals";
                        RunPageMode = View;
                        RunPageLink = Status = const("Rejected");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Procurement Plan Approval action';
                        Caption = 'Plan Requests - Rejected';
                    }
                }
                group(ProcPlanReview)
                {
                    Caption = 'Procurement Plan Review';

                    action("Procurement Plan Review")
                    {
                        Image = PriceWorksheet;
                        RunObject = page "Procurement Plan Review List";
                        ApplicationArea = All;
                        Caption = 'Plan Review - New';
                        RunPageLink = Status = const(Open);
                    }
                    action("Procurement Plan Review-Pending")
                    {
                        Image = PriceWorksheet;
                        RunObject = page "Procurement Plan Review List";
                        RunPageMode = View;
                        RunPageLink = Status = const("Pending Approval");
                        ApplicationArea = All;
                        Caption = 'Plan Review - Pending Approval';
                    }
                    action("Procurement Plan Review-Approved")
                    {
                        Image = PriceWorksheet;
                        RunObject = page "Procurement Plan Review List";
                        RunPageMode = View;
                        RunPageLink = Status = const("Approved");
                        ApplicationArea = All;
                        Caption = 'Plan Review - Approved';
                    }
                    action("Procurement Plan Review-Rejected")
                    {
                        Image = PriceWorksheet;
                        RunObject = page "Procurement Plan Review List";
                        RunPageMode = View;
                        RunPageLink = Status = const("Rejected");
                        ApplicationArea = All;
                        Caption = 'Plan Review - Rejected';
                    }
                }
                group(PlanReports)
                {
                    Caption = 'Reports';
                    action(ProcurementPlansReport)
                    {
                        Caption = 'Procurement Plans';
                        Image = Report;
                        RunObject = report "Procurement Plans";
                        ApplicationArea = All;
                    }
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;

                action("Posted Purchase Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("Posted Return Shipments")
                {
                    ApplicationArea = PurchReturnOrder;
                    Caption = 'Posted Return Shipments';
                    RunObject = page "Posted Return Shipments";
                    ToolTip = 'Open the list of posted return shipments.';
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = page "Posted Purchase Credit Memos";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("Posted Assembly Orders")
                {
                    ApplicationArea = Assembly;
                    Caption = 'Posted Assembly Orders';
                    RunObject = page "Posted Assembly Orders";
                    ToolTip = 'View completed assembly orders.';
                }
            }
            group("Prequalified Suppliers.")
            {
                Caption = 'Prequalified Suppliers';
                action(SupplierCategories)
                {
                    RunObject = page "Supplier Categories";
                    ApplicationArea = All;
                    Caption = 'Supplier Categories';
                }
                action("Prequalified Suppliers ")
                {
                    RunObject = page "Prequalified Suppliers";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Prequalified Suppliers action';
                    Caption = 'Prequalified Suppliers List';
                }
                action("Prequalified Suppliers Report ")
                {
                    RunObject = report "Prequalified Suppliers";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Prequalified Suppliers Report action';
                    Caption = 'Prequalified Suppliers Report';
                }
                action("Prospective Suppliers12")
                {
                    RunObject = page "Prospective Supplier List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Prospective Suppliers action';
                    Caption = 'Prospective Suppliers List';
                }
                action("Supplier Category Code Setup")
                {
                    RunObject = page "Supplier Category Code Setup";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Supplier Category Code Setup action';
                    Caption = 'Supplier Category Code Setup';
                }
                action(UpdateSuppliers)
                {
                    RunObject = report "Update Prospective Suppliers";
                    ApplicationArea = All;
                    Caption = 'Update from Exisiting Vendors';
                }
            }
            group("Procurement and Stores Setups")
            {
                Image = Setup;
                Caption = 'Procurement and Stores Setups';

                action("Purchases & Payables Setup ")
                {
                    RunObject = page "Purchases & Payables Setup";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Supplier Category action';
                    Caption = 'Purchases & Payables Setup';
                }
                action("Procurement Methods")
                {
                    RunObject = page "Procurement Methods List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Procurement Methods action';
                    Caption = 'Procurement Methods';
                }
            }
            group("Project Management")
            {
                Caption = 'Project Management';
                action("Projects")
                {
                    Image = List;
                    RunObject = page "Projects List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Projects action';
                    Caption = 'Projects';
                }
                action("Projects Approved & Ongoing")
                {
                    image = List;
                    RunObject = page "Projects Approved";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Projects Approved & Ongoing action';
                    Caption = 'Projects Approved & Ongoing';
                }
                action("Projects Finished")
                {
                    image = List;
                    RunObject = page "Projects Finished";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Projects Finished action';
                    Caption = 'Projects Finished';
                }
                action("Projects Suspended")
                {
                    Image = List;
                    RunObject = page "Projects Suspended";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Projects Suspended action';
                    Caption = 'Projects Suspended';
                }
                action("Projects Pending Verification")
                {
                    Image = List;
                    RunObject = page "Projects Pending Verification";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Projects Pending Verification action';
                    Caption = 'Projects Pending Verification';
                }
                action("Projects Verified")
                {
                    Image = List;
                    RunObject = page "Projects Verified";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Projects Verified action';
                    Caption = 'Projects Verified';
                }
                action("Project Tasks")
                {
                    Image = Report;
                    RunObject = report "Project Tasks";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Project Tasks action';
                    Caption = 'Project Tasks';
                }
            }
            group(PurchRequisition)
            {
                Caption = 'Purchase Requisitions';

                action("Purchase request list")
                {
                    RunObject = page "Purchase Request List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Purchase request list action';
                    Caption = 'Open Requisitions';
                }
                action("Purchase Req Pending Approval")
                {
                    RunObject = page "Purchase Request Pending";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Purchase Req Pending Approval action';
                    Caption = 'Requisitions Pending Approval';
                }
                action("Purchase Requests Approved All")
                {
                    Image = List;
                    RunObject = page "Purchase Request Approved";
                    RunPageLink = Status = filter(Fulfilled | Released);
                    ApplicationArea = All;
                    ToolTip = 'Executes the Purchase Requests Approved action';
                    Caption = 'All Approved Requisitions';
                }
                action("Purchase Requests Approved")
                {
                    Image = List;
                    RunObject = page "Purchase Request Approved";
                    RunPageLink = "Procurement Request No." = filter('');
                    ApplicationArea = All;
                    ToolTip = 'Executes the Purchase Requests Approved action';
                    Caption = 'Approved not Actioned Requisitions';
                }
                action("Purchase Requests Actioned")
                {
                    Image = List;
                    RunObject = page "Purchase Req Arch List1";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Purchase Requests Fully ordered action';
                    Caption = 'Actioned Requisitions';
                }
                action("Purchase Requests Fully ordered")
                {
                    Image = List;
                    RunObject = page "Purchase Request Approved";
                    RunPageLink = "Fully Ordered" = const(true);
                    ApplicationArea = All;
                    ToolTip = 'Executes the Purchase Requests Fully ordered action';
                    Caption = 'Purchase Requests - Fully ordered';
                    Visible = false;
                }
                action("Request For Quotation")
                {
                    Image = List;
                    RunObject = page "Request for Quote & Order";
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Request For Quotation action';
                    Caption = 'Request For Quotation';
                }
                action("Tracking.")
                {
                    Caption = 'Procurement Status Check';
                    Image = List;
                    RunObject = page "Purchase Request-Tracking";
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Procurement Status Check action';
                }
            }
            group("Receivables")
            {
                Caption = 'Receivables';

                action("Customers")
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    RunObject = page "Customer List";
                    ToolTip = 'Executes the Customers action';
                }
                action("Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Invoices';
                    RunObject = page "Sales Invoice List";
                    ToolTip = 'Executes the Sales Invoices action';
                }
                action("Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Credit Memos';
                    RunObject = page "Sales Credit Memos";
                    ToolTip = 'Executes the Sales Credit Memos action';
                }
                action("Direct Debit Collections")
                {
                    ApplicationArea = Suite;
                    Caption = 'Direct Debit Collections';
                    RunObject = page "Direct Debit Collections";
                    ToolTip = 'Executes the Direct Debit Collections action';
                }
                action("Create Recurring Sales Invoice")
                {
                    ApplicationArea = All;
                    Caption = 'Create Recurring Sales Invoices';
                    RunObject = report "Create Recurring Sales Inv.";
                    ToolTip = 'Executes the Create Recurring Sales Invoices action';
                }
                action("Register Customer Payments")
                {
                    ApplicationArea = All;
                    Caption = 'Register Customer Payments';
                    RunObject = page "Payment Registration";
                    ToolTip = 'Executes the Register Customer Payments action';
                }
                group("Group29")
                {
                    Caption = 'Combine';

                    action("Combined Shipments")
                    {
                        ApplicationArea = All;
                        Caption = 'Combine Shipments...';
                        RunObject = report "Combine Shipments";
                        ToolTip = 'Executes the Combine Shipments... action';
                    }
                    action("Combined Return Receipts")
                    {
                        ApplicationArea = SalesReturnOrder, PurchReturnOrder;
                        Caption = 'Combine Return Receipts...';
                        RunObject = report "Combine Return Receipts";
                        ToolTip = 'Executes the Combine Return Receipts... action';
                    }
                }
                group("Group30")
                {
                    Caption = 'Collection';

                    action("Reminders")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Reminders';
                        RunObject = page "Reminder List";
                        ToolTip = 'Executes the Reminders action';
                    }
                    action("Issued Reminders")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Issued Reminders';
                        RunObject = page "Issued Reminder List";
                        ToolTip = 'Executes the Issued Reminders action';
                    }
                    action("Finance Charge Memos")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Finance Charge Memos';
                        RunObject = page "Finance Charge Memo List";
                        ToolTip = 'Executes the Finance Charge Memos action';
                    }
                    action("Issued Finance Charge Memos")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Issued Finance Charge Memos';
                        RunObject = page "Issued Fin. Charge Memo List";
                        ToolTip = 'Executes the Issued Finance Charge Memos action';
                    }
                }
                group("Group31")
                {
                    Caption = 'Journals';

                    action("Journals")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Journals';
                        RunObject = page "Sales Journal";
                        ToolTip = 'Executes the Sales Journals action';
                    }
                    action("Cash Receipt Journal1")
                    {
                        ApplicationArea = All;
                        Caption = 'Cash Receipt Journals';
                        RunObject = page "Cash Receipt Journal";
                        ToolTip = 'Executes the Cash Receipt Journals action';
                    }
                }
                group("Group33")
                {
                    Caption = 'Registers/Entries';

                    action("G/L Registers1")
                    {
                        ApplicationArea = All;
                        Caption = 'G/L Registers';
                        RunObject = page "G/L Registers";
                        ToolTip = 'Executes the G/L Registers action';
                    }
                    action("Customer Ledger Entries")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Ledger Entries';
                        RunObject = page "Customer Ledger Entries";
                        ToolTip = 'Executes the Customer Ledger Entries action';
                    }
                    action("Reminder/Fin. Charge Entries")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Reminder/Fin. Charge Entries';
                        RunObject = page "Reminder/Fin. Charge Entries";
                        ToolTip = 'Executes the Reminder/Fin. Charge Entries action';
                    }
                    action("Detailed Cust. Ledg. Entries")
                    {
                        ApplicationArea = All;
                        Caption = 'Detailed Customer Ledger Entries';
                        RunObject = page "Detailed Cust. Ledg. Entries";
                        ToolTip = 'Executes the Detailed Customer Ledger Entries action';
                    }
                }
                group("Group34")
                {
                    Caption = 'Reports';

                    action("Customer Detailed Aging")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Detailed Aging';
                        RunObject = report "Customer Detailed Aging";
                        ToolTip = 'Executes the Customer Detailed Aging action';
                    }
                    action("Customer Statement")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Statement';
                        RunObject = codeunit "Customer Layout - Statement";
                        ToolTip = 'Executes the Customer Statement action';
                    }
                    action("Customer Register")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Register';
                        RunObject = report "Customer Register";
                        ToolTip = 'Executes the Customer Register action';
                    }
                    action("Customer - Balance to Date")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer - Balance to Date';
                        RunObject = report "Customer - Balance to Date";
                        ToolTip = 'Executes the Customer - Balance to Date action';
                    }
                    action("Customer - Detail Trial Bal.")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer - Detail Trial Bal.';
                        RunObject = report "Customer - Detail Trial Bal.";
                        ToolTip = 'Executes the Customer - Detail Trial Bal. action';
                    }
                    action("Customer - List")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer - List';
                        RunObject = report "Customer - List";
                        ToolTip = 'Executes the Customer - List action';
                    }
                    action("Customer - Summary Aging")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer - Summary Aging';
                        RunObject = report "Customer - Summary Aging";
                        ToolTip = 'Executes the Customer - Summary Aging action';
                    }
                    action("Customer - Summary Aging Simp.")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Summary Aging Simp.';
                        RunObject = report "Customer - Summary Aging Simp.";
                        ToolTip = 'Executes the Customer - Summary Aging Simp. action';
                    }
                    action("Customer - Order Summary")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer - Order Summary';
                        RunObject = report "Customer - Order Summary";
                        ToolTip = 'Executes the Customer - Order Summary action';
                    }
                    action("Customer - Order Detail")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer - Order Detail';
                        RunObject = report "Customer - Order Detail";
                        ToolTip = 'Executes the Customer - Order Detail action';
                    }
                    action("Customer - Labels")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer Labels';
                        RunObject = report "Customer - Labels";
                        ToolTip = 'Executes the Customer Labels action';
                    }
                    action("Customer - Top 10 List")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Top 10 List';
                        RunObject = report "Customer - Top 10 List";
                        ToolTip = 'Executes the Customer Top 10 List action';
                    }
                    action("Sales Statistics")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Statistics';
                        RunObject = report "Sales Statistics";
                        ToolTip = 'Executes the Sales Statistics action';
                    }
                    action("Customer/Item Sales")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer/Item Sales';
                        RunObject = report "Customer/Item Sales";
                        ToolTip = 'Executes the Customer/Item Sales action';
                    }
                    action("Salesperson - Sales Statistics")
                    {
                        ApplicationArea = All;
                        Caption = 'Salesperson Sales Statistics';
                        RunObject = report "Salesperson - Sales Statistics";
                        ToolTip = 'Executes the Salesperson Sales Statistics action';
                    }
                    action("Salesperson - Commission")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Salesperson Commission';
                        RunObject = report "Salesperson - Commission";
                        ToolTip = 'Executes the Salesperson Commission action';
                    }
                    action("Customer - Sales List")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer - Sales List';
                        RunObject = report "Customer - Sales List";
                        ToolTip = 'Executes the Customer - Sales List action';
                    }
                    action("Aged Accounts Receivable")
                    {
                        ApplicationArea = All;
                        Caption = 'Aged Accounts Receivable';
                        RunObject = report "Aged Accounts Receivable";
                        ToolTip = 'Executes the Aged Accounts Receivable action';
                    }
                    action("Customer - Trial Balance")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Trial Balance';
                        RunObject = report "Customer - Trial Balance";
                        ToolTip = 'Executes the Customer Trial Balance action';
                    }
                    action("EC Sales List")
                    {
                        ApplicationArea = All;
                        Caption = 'EC Sales List';
                        RunObject = report "EC Sales List";
                        ToolTip = 'Executes the EC Sales List action';
                    }
                }
                group("Group35")
                {
                    Caption = 'Setup';

                    action("Sales & Receivables Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales & Receivables Setup';
                        RunObject = page "Sales & Receivables Setup";
                        ToolTip = 'Executes the Sales & Receivables Setup action';
                    }
                    action("Payment Registration Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Registration Setup';
                        RunObject = page "Payment Registration Setup";
                        ToolTip = 'Executes the Payment Registration Setup action';
                    }
                    action("Report Selection Reminder and")
                    {
                        ApplicationArea = All;
                        Caption = 'Report Selections Reminder/Fin. Charge';
                        RunObject = page "Report Selection - Reminder";
                        ToolTip = 'Executes the Report Selections Reminder/Fin. Charge action';
                    }
                    action("Reminder Terms")
                    {
                        ApplicationArea = All;
                        Caption = 'Reminder Terms';
                        RunObject = page "Reminder Terms";
                        ToolTip = 'Executes the Reminder Terms action';
                    }
                    action("Finance Charge Terms")
                    {
                        ApplicationArea = All;
                        Caption = 'Finance Charge Terms';
                        RunObject = page "Finance Charge Terms";
                        ToolTip = 'Executes the Finance Charge Terms action';
                    }
                }
            }
            group("Request for Proposal")
            {
                Caption = 'Request for Proposal';

                action("RFP List")
                {
                    Image = List;
                    RunObject = page "RFP List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the RFP List action';
                    Caption = 'RFP List';
                }
                action("RFP Archive list")
                {
                    Image = List;
                    RunObject = page "RFP Archive List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the RFP Archive list action';
                    Caption = 'RFP Archive list';
                }
                group("RFP Committees")
                {
                    Caption = 'RFP Committees';
                    action("RFP Committee")
                    {
                        image = List;
                        RunObject = page "Committee Creation";
                        RunPageLink = Status = const(Open);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Tender Committee action';
                        Caption = 'RFP Committee';
                    }
                    action("RFP Committee - Pending Approval")
                    {
                        image = List;
                        RunObject = page "Committee Creation";
                        RunPageLink = Status = const("Pending Approval");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Tender Committee action';
                        Caption = 'RFP Committee - Pending Approval';
                    }
                    action("RFP Committee - Approved")
                    {
                        image = List;
                        RunObject = page "Committee Creation";
                        RunPageLink = Status = const(Released);
                        RunPageMode = View;
                        ApplicationArea = All;
                        ToolTip = 'Executes the Approved RFP Committee action';
                        Caption = 'RFP Committee - Approved';
                    }
                }
                group("RFP Opening")
                {
                    Caption = 'RFP Opening';

                    action(RFPOpening)
                    {
                        Caption = 'RFP Opening';
                        RunObject = page "Tender Opening List";
                        RunPageLink = "Tender Opened" = const(false), "Document Type" = const(Tender);
                        ApplicationArea = All;
                    }
                    action(RFPOpeningArchive)
                    {
                        Caption = 'RFPs Opened';
                        RunObject = page "Tender Opening List";
                        RunPageLink = "Tender Opened" = const(true), "Document Type" = const(Tender);
                        ApplicationArea = All;
                    }
                }
                group("RFPPreliminary")
                {
                    Caption = 'Preliminary Evaluation';

                    action("RFPSupplier Evaluation-Preliminary")
                    {
                        Image = List;
                        RunObject = page "Supplier Evaluation List";
                        RunPageLink = "Evaluation Stage" = const("Preliminary Evaluation");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation action';
                        Caption = 'Supplier Evaluation-Preliminary';
                    }
                    action("RFPSupplier Evaluation-Failed Preliminary")
                    {
                        Image = List;
                        RunObject = page "Supplier Evaluation List";
                        RunPageLink = "Evaluation Stage" = const("Failed Preliminary");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation action';
                        Caption = 'Failed Preliminary Evaluation';
                    }
                }
                group("RFPTechnical Evaluation")
                {
                    Caption = 'Technical Evaluation';
                    action("RFPSupplier Evaluation-Technical")
                    {
                        Image = List;
                        RunObject = page "Supplier Evaluation List";
                        RunPageLink = "Evaluation Stage" = const("Technical Evaluation");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation action';
                        Caption = 'Supplier Evaluation-Technical';
                    }
                    action("RFPSupplier Evaluation-Failed Technical")
                    {
                        Image = List;
                        RunObject = page "Supplier Evaluation List";
                        RunPageLink = "Evaluation Stage" = const("Failed Technical");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation action';
                        Caption = 'Failed Technical Evaluation';
                    }
                }
                group("RFPFinancial Evaluation")
                {
                    Caption = 'Financial Evaluation';
                    action("RFP Evaluation list")
                    {
                        Image = List;
                        RunObject = page "Tender Evaluation List";
                        RunPageLink = Status = const(New);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Financial evaluation list action';
                        Caption = 'Financial Evaluation List';
                    }
                    action("RFP evaluation pending list")
                    {
                        Image = List;
                        RunObject = page "Tender Evaluation List";
                        RunPageLink = Status = const("Pending Approval");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Financial evaluation list action';
                        Caption = 'Financial Evaluation List-Pending Approval';
                    }
                    action("RFP evaluation list-Approved")
                    {
                        Image = List;
                        RunObject = page "Tender Evaluation List";
                        RunPageLink = Status = const(Approved);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Financial Evaluation list-Approved action';
                        Caption = 'Financial Evaluation List-Approved';
                    }
                }
                group("RFPAward")
                {
                    Caption = 'Award Report Process';
                    action("RFP evaluation list-Award")
                    {
                        Image = List;
                        RunObject = page "Tender Evaluation-Award";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Financial Evaluation list-Approved action';
                        Caption = 'RFP Award';
                    }
                    action("RFPEvaluation archive list")
                    {
                        Image = List;
                        RunObject = page "Tender Evaluation List-Archive";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Tender evaluation archive list action';
                        Caption = 'RFP Award - Processed';
                    }
                }
                group("RFPSupplier Evaluation History")
                {
                    Caption = 'Supplier Evaluation History';

                    action("RFPSupplier Evaluation-Submitted")
                    {
                        Image = List;
                        RunObject = page "Supplier Evaluation Approved";
                        RunPageLink = Status = const(Approved);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation-Submitted action';
                        Caption = 'Supplier Evaluation-Submitted';
                    }
                }
                group(RFPSetups)
                {
                    Caption = 'Setups';
                    action("RFPSupplier Evaluation Setup")
                    {
                        Caption = 'Supplier Evaluation Criteria Setup';
                        Image = List;
                        RunObject = page "Supplier Evaluation Setup";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation Criteria Setup action';
                    }
                }
            }
            group(RequestForQuotation)
            {
                Caption = 'Request For Quotation';
                group(RFQS)
                {
                    Caption = 'Request For Quotations';
                    action("Quotation list ")
                    {
                        Image = List;
                        RunObject = page "Quotation List";
                        RunPageLink = Status = const(New);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Quotation list  action';
                        Caption = 'New Request For Quotations';
                    }
                    action("Quotation list-Issued")
                    {
                        Image = List;
                        RunObject = page "Quotation List";
                        RunPageLink = Status = const(Issued);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Quotation list  action';
                        Caption = 'Issued Request For Quotations';
                    }
                    action("Quotation archive list")
                    {
                        Image = List;
                        RunObject = page "Quotation List-Archive";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Quotation archive list action';
                        Caption = 'Archived Request For Quotations';
                    }
                }
                group("Quote Evaluation")
                {
                    Caption = 'Request For Quote Evaluation';

                    action("Quote evaluation list")
                    {
                        Image = List;
                        RunObject = page "Quote Evaluation List";
                        RunPageLink = Status = filter(<> Approved);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Quote evaluation list action';
                        Caption = 'Request For Quote Evaluation list';
                    }
                    action("Quote evaluation list-Approved")
                    {
                        Image = List;
                        RunObject = page "Quote Evaluation List";
                        RunPageLink = Status = const(Approved);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Quote evaluation list-Approved action';
                        Caption = 'Request For Quote Evaluation-Approved';
                    }
                    action("Quote evaluation archive list")
                    {
                        Image = List;
                        RunObject = page "Quote Evaluation Archive";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Quote evaluation archive list action';
                        Caption = 'Request For Quote Evaluation - Archive';
                    }
                }
            }
            group("Supplier Prequalification")
            {
                Caption = 'Supplier Prequalification';

                action("Prospective Suppliers15")
                {
                    RunObject = page "Prospective Supplier List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Prospective Suppliers action';
                    Caption = 'Prospective Suppliers List';
                }
                group("Prequalification Tender ")
                {
                    Caption = 'Prequalification Tenders';
                    action("Prequalification Tender")
                    {
                        ApplicationArea = All;
                        RunObject = page "Supplier Prequalify Tender";
                        RunPageLink = Status = const(New);
                        Caption = 'Prequalification Tender';
                    }
                    action("Prequalification Tender-Pending")
                    {
                        ApplicationArea = All;
                        RunObject = page "Supplier Prequalify Tender";
                        RunPageLink = Status = const("Pending Approval");
                        Caption = 'Prequalification - Pending Approval';
                    }
                    action("Prequalification Tender-Approved")
                    {
                        ApplicationArea = All;
                        RunObject = page "Supplier Prequalify Tender";
                        RunPageLink = Status = const(Approved);
                        Caption = 'Prequalification - Approved';
                    }
                }
                group("PrequalificationOpening")
                {
                    Caption = 'Tender Opening';

                    action(PrequalificationTenderOpening)
                    {
                        Caption = 'Tender Opening';
                        RunObject = page "Tender Opening List";
                        RunPageLink = "Tender Opened" = const(false), "Document Type" = const("Supplier Prequalification");
                        ApplicationArea = All;
                    }
                    action(PrequalificationTenderOpeningArchive)
                    {
                        Caption = 'Tender Opening Archive';
                        RunObject = page "Tender Opening List";
                        RunPageLink = "Tender Opened" = const(true), "Document Type" = const("Supplier Prequalification");
                        ApplicationArea = All;
                    }
                }
                group("Prequalification1")
                {
                    Caption = 'Prequalification Evaluation';

                    action("Supplier Evaluation-Prequalification")
                    {
                        Image = List;
                        RunObject = page "Supplier Evaluation List";
                        RunPageLink = "Evaluation Stage" = const("Supplier Prequalification");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation action';
                        Caption = 'Supplier Evaluation-Prequalification';
                    }
                    action("Supplier Evaluation-Passed Prequalification")
                    {
                        Image = List;
                        RunObject = page "Supplier Evaluation List";
                        RunPageLink = "Evaluation Stage" = const("Passed Supplier Prequalification");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation action';
                        Caption = 'Passed Prequalification';
                    }
                    action("Supplier Evaluation-Failed Prequalification")
                    {
                        Image = List;
                        RunObject = page "Supplier Evaluation List";
                        RunPageLink = "Evaluation Stage" = const("Failed Supplier Prequalification");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation action';
                        Caption = 'Failed Prequalification';
                    }
                }
                group("Tender Committees2")
                {
                    Caption = 'Tender Committees';
                    action("Tender Committee2")
                    {
                        image = List;
                        RunObject = page "Committee Creation";
                        RunPageLink = Status = const(Open);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Tender Committee action';
                        Caption = 'Tender Committee';
                    }
                    action("Tender Committee - Pending Approval2")
                    {
                        image = List;
                        RunObject = page "Committee Creation";
                        RunPageLink = Status = const("Pending Approval");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Tender Committee action';
                        Caption = 'Tender Committee - Pending Approval';
                    }
                    action("Tender Committee - Approved2")
                    {
                        image = List;
                        RunObject = page "Committee Creation";
                        RunPageLink = Status = const(Released);
                        RunPageMode = View;
                        ApplicationArea = All;
                        ToolTip = 'Executes the Approved Tender Committee action';
                        Caption = 'Tender Committee - Approved';
                    }
                }
            }
            group(StoreRequisition)
            {
                Caption = 'Store Requisitions';

                action(StoreReq)
                {
                    Caption = 'New Store Requests';
                    Image = List;
                    RunObject = page "Store Request List";
                    ApplicationArea = All;
                    ToolTip = 'Executes the New Store Requests action';
                }
                action("Store Requests-Pending")
                {
                    Image = List;
                    RunObject = page "Pending Store Request";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Store Requests-Pending action';
                    Caption = 'Store Requests-Pending';
                }
                action("Store Requests-Approved")
                {
                    Image = List;
                    RunObject = page "Approved Store Request";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Store Requests-Approved action';
                    Caption = 'Store Requests-Approved';
                }
            }
            group("Supplier Categories")
            {
                action(SupplierCategories1)
                {
                    RunObject = page "Supplier Categories";
                    ApplicationArea = All;
                    Caption = 'Supplier Categories';
                }
                action("Supplier Category Code Setup1")
                {
                    RunObject = page "Supplier Category Code Setup";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Supplier Category Code Setup action';
                    Caption = 'Supplier Category Code Setup';
                }
            }
            group("Tender Management")
            {
                Caption = 'Tender Management';
                group("Tenders")
                {
                    Caption = 'Tenders';
                    group(OpenTenders)
                    {
                        Caption = 'Open Tenders';
                        action("Open Tenders-New")
                        {
                            Caption = 'Open Tenders-New';
                            Image = List;
                            RunObject = page "Tender List";
                            RunPageLink = Status = const(New);
                            ApplicationArea = All;
                            ToolTip = 'Executes the Open Tenders action';
                        }
                        action("Open Tenders-Evaluation")
                        {
                            Caption = 'Open Tenders-Evaluation';
                            Image = List;
                            RunObject = page "Tender List";
                            RunPageLink = Status = filter(Opening | Evaluation);
                            ApplicationArea = All;
                            ToolTip = 'Executes the Open Tenders action';
                        }
                        action("Tender archive list-Open")
                        {
                            Image = List;
                            RunObject = page "Tender Archive List";
                            RunPageLink = "Tender Type" = const(Open);
                            ApplicationArea = All;
                            ToolTip = 'Executes the Tender archive list action';
                            Caption = 'Tenders Awarded Report - Open';
                        }
                    }
                    group(RestrictedTenders)
                    {
                        Caption = 'Restricted Tenders';

                        action("Restricted Tenders-New")
                        {
                            Caption = 'Restricted Tenders';
                            Image = List;
                            RunObject = page "Restricted Tender List";
                            RunPageLink = Status = const(New);
                            ApplicationArea = All;
                            ToolTip = 'Executes the Restricted Tenders action';
                        }
                        action("Restricted Tenders-Evaluation")
                        {
                            Caption = 'Restricted Tenders';
                            Image = List;
                            RunObject = page "Restricted Tender List";
                            RunPageLink = Status = filter(Opening | Evaluation);
                            ApplicationArea = All;
                            ToolTip = 'Executes the Restricted Tenders action';
                        }
                        action("Tender archive list-Restricted")
                        {
                            Image = List;
                            RunObject = page "Tender Archive List";
                            RunPageLink = "Tender Type" = const(Restricted);
                            ApplicationArea = All;
                            ToolTip = 'Executes the Tender archive list action';
                            Caption = 'Tenders Awarded Report-Restricted';
                        }
                    }
                }
                group("Tender Committees")
                {
                    Caption = 'Tender Committees';
                    action("Tender Committee")
                    {
                        image = List;
                        RunObject = page "Committee Creation";
                        RunPageLink = Status = const(Open);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Tender Committee action';
                        Caption = 'Tender Committee';
                    }
                    action("Tender Committee - Pending Approval")
                    {
                        image = List;
                        RunObject = page "Committee Creation";
                        RunPageLink = Status = const("Pending Approval");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Tender Committee action';
                        Caption = 'Tender Committee - Pending Approval';
                    }
                    action("Tender Committee - Approved")
                    {
                        image = List;
                        RunObject = page "Committee Creation";
                        RunPageLink = Status = const(Released);
                        RunPageMode = View;
                        ApplicationArea = All;
                        ToolTip = 'Executes the Approved Tender Committee action';
                        Caption = 'Tender Committee - Approved';
                    }
                }
                group("Prospective Suppliers")
                {
                    Caption = 'Prequalified Suppliers';
                    Visible = false;

                    action("Supplier List")
                    {
                        Caption = 'Prequalified Suppliers';
                        Image = List;
                        RunObject = page "Prospective Supplier List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Prequalified Suppliers action';
                        Visible = false;
                    }
                    action("Suppliers Under Evaluation List")
                    {
                        Caption = 'Prequalified Suppliers Under Evaluation';
                        Image = List;
                        Visible = false;
                        RunObject = page "Prospective Supplier List";
                        RunPageLink = "Supplier Status" = const(Evaluation);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Prequalified Suppliers Under Evaluation action';
                    }
                }
                group("Opening")
                {
                    Caption = 'Tender Opening';

                    action(TenderOpening)
                    {
                        Caption = 'Tender Opening';
                        RunObject = page "Tender Opening List";
                        RunPageLink = "Tender Opened" = const(false), "Document Type" = const(Tender);
                        ApplicationArea = All;
                    }
                    action(TenderOpeningArchive)
                    {
                        Caption = 'Tenders Opened';
                        RunObject = page "Tender Opening List";
                        RunPageLink = "Tender Opened" = const(true), "Document Type" = const(Tender);
                        ApplicationArea = All;
                    }
                }
                group("Preliminary")
                {
                    Caption = 'Preliminary Evaluation';

                    action("Supplier Evaluation-Preliminary")
                    {
                        Image = List;
                        RunObject = page "Supplier Evaluation List";
                        RunPageLink = "Evaluation Stage" = const("Preliminary Evaluation");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation action';
                        Caption = 'Supplier Evaluation-Preliminary';
                    }
                    action("Supplier Evaluation-Failed Preliminary")
                    {
                        Image = List;
                        RunObject = page "Supplier Evaluation List";
                        RunPageLink = "Evaluation Stage" = const("Failed Preliminary");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation action';
                        Caption = 'Failed Preliminary Evaluation';
                    }
                }
                group("Technical Evaluation")
                {
                    action("Supplier Evaluation-Technical")
                    {
                        Image = List;
                        RunObject = page "Supplier Evaluation List";
                        RunPageLink = "Evaluation Stage" = const("Technical Evaluation");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation action';
                        Caption = 'Supplier Evaluation-Technical';
                    }
                    action("Supplier Evaluation-Failed Technical")
                    {
                        Image = List;
                        RunObject = page "Supplier Evaluation List";
                        RunPageLink = "Evaluation Stage" = const("Failed Technical");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation action';
                        Caption = 'Failed Technical Evaluation';
                    }
                }
                group("Financial Evaluation")
                {
                    Caption = 'Financial Evaluation';

                    action("Tender evaluation list")
                    {
                        Image = List;
                        RunObject = page "Tender Evaluation List";
                        RunPageLink = Status = const(New);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Financial evaluation list action';
                        Caption = 'Financial Evaluation List';
                    }
                    action("Tender evaluation pending list")
                    {
                        Image = List;
                        RunObject = page "Tender Evaluation List";
                        RunPageLink = Status = const("Pending Approval");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Financial evaluation list action';
                        Caption = 'Financial Evaluation List-Pending Approval';
                    }
                    action("Tender evaluation list-Approved")
                    {
                        Image = List;
                        RunObject = page "Tender Evaluation List";
                        RunPageLink = Status = const(Approved);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Financial Evaluation list-Approved action';
                        Caption = 'Financial Evaluation List-Approved';
                    }
                }
                group("Award")
                {
                    Caption = 'Award Report Process';
                    action("Tender evaluation list-Award")
                    {
                        Image = List;
                        RunObject = page "Tender Evaluation-Award";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Financial Evaluation list-Approved action';
                        Caption = 'Tender Award';
                    }
                    action("Tender evaluation archive list")
                    {
                        Image = List;
                        RunObject = page "Tender Evaluation List-Archive";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Tender evaluation archive list action';
                        Caption = 'Tender Award - Processed';
                    }
                }
                group("Supplier Evaluation History")
                {
                    Caption = 'Supplier Evaluation History';

                    action("Supplier Evaluation-Submitted")
                    {
                        Image = List;
                        RunObject = page "Supplier Evaluation Approved";
                        RunPageLink = Status = const(Approved);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation-Submitted action';
                        Caption = 'Supplier Evaluation-Submitted';
                    }
                }
                group(TenderSetups)
                {
                    Caption = 'Setups';
                    action("Supplier Evaluation Setup")
                    {
                        Caption = 'Supplier Evaluation Criteria Setup';
                        Image = List;
                        RunObject = page "Supplier Evaluation Setup";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Supplier Evaluation Criteria Setup action';
                    }
                }
            }
            group(Tracking)
            {
                Caption = 'Tracking';
                Visible = false;
                action("Procurement Status Check")
                {
                    RunObject = page "Purchase Request-Tracking";
                    ApplicationArea = All;
                    ToolTip = 'Executes the Procurement Status Check action';
                    Caption = 'Procurement Status Check';
                    Visible = false;
                }
            }


            group("Transport Management")
            {
                Caption = 'Transport Management';
                action("Fleet List")
                {
                    ApplicationArea = all;
                    RunObject = page "Fleet List";
                    ToolTip = 'Executes the Fleet List action';
                    Caption = 'Fleet List';
                }
                action("Transport Requests List")
                {
                    ApplicationArea = all;
                    RunObject = page "Trip Listing";
                    ToolTip = 'Executes the Transport Requests List action';
                    Caption = 'Transport Requests List';
                }
                action("Approved Transport Requests")
                {
                    ApplicationArea = all;
                    RunObject = page "Approved Travel Requests";
                    ToolTip = 'Executes the Approved Transport Requests action';
                    Caption = 'Approved Transport Requests';
                }
                action("Maintenance and Repair")
                {
                    ApplicationArea = all;
                    RunObject = page "Maintenance Registration";
                    ToolTip = 'Executes the Maintenance and Repair action';
                    Caption = 'Maintenance and Repair';
                }
                action("Travel Expenses")
                {
                    ApplicationArea = all;
                    RunObject = page "Travel Expense";
                    ToolTip = 'Executes the Travel Expenses action';
                    Caption = 'Travel Expenses';
                }
                group("Transport Management Archive")
                {
                    Caption = 'Transport Management Archive';
                    action("Completed Travels")
                    {
                        ApplicationArea = all;
                        RunObject = page "Completed Travels";
                        ToolTip = 'Executes the Completed Travels action';
                        Caption = 'Completed Travels';
                    }
                }

                group(TransportReports)
                {
                    Caption = 'Transport Reports';

                    action("Transport Requests ")
                    {
                        ApplicationArea = all;
                        RunObject = report "Transport Requests";
                        Caption = 'Transport Requests';
                    }
                }
            }

        }
    }
}





