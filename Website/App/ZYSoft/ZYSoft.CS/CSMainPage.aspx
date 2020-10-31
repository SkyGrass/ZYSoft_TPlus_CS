<%@ Page Language="C#" AutoEventWireup="true" %>

<%-- CodeFile="CSMainPage.aspx.cs" Inherits="App_ZYSoft_ZYSoft_CS_CSMainPage" --%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>请购单</title>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="./css/element-ui-index.css" />
    <link rel="stylesheet" href="./css/theme-chalk-index.css">
    <%--<link rel="stylesheet" href="./css/index.css" />--%>
    <!-- 引入组件库 -->
    <%--<link rel="stylesheet" href="./assets/icon/iconfont.css" />--%>
    <link href="./css/tabulator.min.css" rel="stylesheet" />
    <style>
        .el-dialog__body {
            padding: 10px 10px;
        }

        .el-card__body {
            padding: 10px !important;
        }

        .el-dialog {
            margin-top: 1vh !important;
        }

        .tabulator .tabulator-header .tabulator-col {
            text-align: center;
        }

        .tabulator-tableHolder {
            background-color: #fff;
        }

        .border {
            border: 1px solid #808080;
            padding: 5px;
        }

        .el-input__inner {
            background-color: transparent;
        }

        .tabulator .tabulator-header {
            font-weight: inherit;
        }

        html {
            font-family: "Microsoft Yahei";
            font-size: 11px !important;
        }

        .el-form--inline .el-form-item__label {
            text-align: center !important;
        }

        .el-form--label-left .el-form-item__label {
            text-align: center !important;
        }
    </style>
</head>

<body>
    <asp:Label ID="lblUserName" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lbUserId" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lbUserCode" runat="server" Visible="false"></asp:Label>
    <div id="app">
        <el-container>  
                <el-container class="contain">
                    <el-header id="header" style="height:inherit !important">
                      
                        <el-form :model="form" label-position="left" label-width="80px" size="mini">
                            <el-row :gutter="16">
                                <el-col :span="4">
                                    <el-form-item label="销售订单">
                                        <el-input placeholder="请输入销售订单" v-model="form.ordercode" clearable>
                                        </el-input>
                                    </el-form-item> 
                                </el-col> 
                                 <el-col :span="4">
                                    <el-form-item label="客户">
                                      <el-input placeholder="请输入客户编码、客户名称" v-model="form.customer" clearable>
                                        </el-input>
                                    </el-form-item> 
                                </el-col> 
                                 <el-col :span="6"> 
                                    <el-form-item label="日期">
                                      <el-date-picker 
                                         v-model="form.date"
                                         type="daterange"
                                         placeholder="选择日期">
                                     </el-date-picker>
                                 </el-col>
                            </el-row>  
                       </el-form>
                    </el-header>
                    <el-main style="padding-top:0px">  
                        <el-row>
                          <el-col :span="8">
                               <el-card v-loading="loading">
                                    <el-button-group style="padding-bottom:5px">
                                        <el-button @click="queryOrder" size="mini" icon="el-icon-search" :loading ="loading" >查询</el-button>  
                                    </el-button-group>
                                    <div style="width:100%" id="grid"></div>
                                </el-card>
                          </el-col>
                          <el-col :span="16"  >
                              <el-card v-loading="loading">
                                  <el-button-group style="padding-bottom:5px">
                                        <el-button @click="addRow" size="mini"  :disabled="forbiddenUse"   icon="el-icon-plus" :loading ="loading" >增行</el-button> 
                                        <el-button @click="delRow" size="mini"  :disabled="forbiddenDelete"  icon="el-icon-delete" :loading ="loading" >删行</el-button> 
                                        <el-button @click="saveTable" size="mini" :disabled="forbiddenUse"   icon="el-icon-document" :loading ="loading" >保存</el-button> 
                                    </el-button-group> 
                                    <div style="width:100%" id="gridDetail"></div>
                               </el-card>
                          </el-col>
                        </el-row>
                    </el-main>
                </el-container> 
           </el-container>
        <el-dialog title="存货查询" width="50%" :visible.sync="showPicker">
              <el-input placeholder="存货名称、存货编码 进行检索" focus  v-model="querMaterialform.keyword" @change="remoteQueryMaterial">
              </el-input>  
           <el-table
               size="mini"
                ref="multipleTable"
                :data="materialInfo"
                tooltip-effect="dark"
                :height="maxHeightForDia"
                style="width: 100%"
                border
                stripe 
                @selection-change="handleSelectionChange"> 
               <el-table-column
                  type="selection"
                  align="center"
                  width="55">
                </el-table-column>
                <el-table-column
                  prop="code"
                  align="center"
                  label="存货编码"
                  width="120">
                </el-table-column>
                <el-table-column
                  prop="name"
                  align="center"
                  label="存货名称"
                  width="250"
                  show-overflow-tooltip>
                </el-table-column>
                <el-table-column
                  prop="specification"
                  align="center"
                  label="规格型号"
                  width="250"
                  show-overflow-tooltip>
                </el-table-column>
               <el-table-column
                  prop="unitname"
                  align="center"
                  label="单位"
                  width="80">
                </el-table-column>
              </el-table>
            <div slot="footer" class="dialog-footer">
                <el-button @click="showPicker = false">取 消</el-button>
                <el-button type="primary" @click="confirm">确定</el-button>
            </div>
        </el-dialog>
    </div>
    <script src="./js/moment.js"></script>
    <script src="./js/tableconfig.js"></script>
    <script src="./js/vue.js"></script>
    <script src="./js/element-ui-index.js"></script>
    <script src="./js/tabulator.js"></script>
    <script src="./js/jquery.min.js"></script>
    <script>
        var loginName = "<%=lblUserName.Text%>"
        var loginUserId = "<%=lbUserId.Text%>"
        var loginUserCode = "<%=lbUserCode.Text%>"
    </script>

    <script src="js/cs.js"></script>
</body>

</html>
