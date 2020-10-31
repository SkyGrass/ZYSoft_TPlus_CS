const tableconf_main = [
{
    title: "销售订单",
    field: "code",
    hozAlign: "center",
    width: 150,
    headerSort: false
},
{
    title: "日期",
    field: "voucherdate",
    hozAlign: "center",
    width: 120,
    headerSort: false,
    formatter: "datetime",
    formatterParams: {
        inputFormat: "YYYY-MM-DD",
        outputFormat: "YYYY-MM-DD",
        invalidPlaceholder: "",
    }
},
{
    title: "客户",
    field: "customer",
    hozAlign: "center",
    width: 200,
    headerSort: false
},
//{
//    title: "行号",
//    field: "ID",
//    hozAlign: "center",
//    width: 50,
//    headerSort: false
//},
{
    title: "产品编码",
    field: "cinvcode",
    hozAlign: "center",
    headerSort: false,
    width: 150,
},
{
    title: "产品名称",
    field: "cinvname",
    hozAlign: "center",
    headerSort: false,
    width: 200,
},
{
    title: "规格型号",
    field: "cinvstd",
    hozAlign: "center",
    headerSort: false,
    width: 250
},
{
    title: "数量",
    field: "quantity",
    hozAlign: "right",
    width: 80,
    headerSort: false,
    editor: false,
},
{
    title: "物料清单",
    field: "idbom",
    hozAlign: "center",
    headerSort: false,
    width: 80
},
{
    title: "版本号",
    field: "version",
    hozAlign: "center",
    headerSort: false,
    width: 100
}
]


const tableconf_detail = [
    //{
    //    title: "序号",
    //    field: "id",
    //    hozAlign: "center",
    //    width: 80,
    //    headerSort: false
    //},
    {
        title: "子件编码",
        field: "cinvcode",
        hozAlign: "center",
        width: 150,
        headerSort: false
    }, {
        title: "子件名称",
        field: "cinvname",
        hozAlign: "center",
        width: 250,
        headerSort: false
    },{
        title: "计量单位",
        field: "cunit",
        hozAlign: "center",
        width: 100,
        headerSort: false
    }, {
        title: "需用数量",
        field: "requiredquantity",
        headerSort: false,
        hozAlign: "right", editor: "input",
        editor: true, validator: ["min:0", "numeric"]
    }
]
