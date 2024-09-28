﻿$PBExportHeader$w_empl_dw_share_buffers.srw
$PBExportComments$Three DWs sharing one set of buffers
forward
global type w_empl_dw_share_buffers from w_center
end type
type tab_emp from tab within w_empl_dw_share_buffers
end type
type tabpage_employment from userobject within tab_emp
end type
type dw_emp from datawindow within tabpage_employment
end type
type tabpage_employment from userobject within tab_emp
dw_emp dw_emp
end type
type tabpage_address from userobject within tab_emp
end type
type dw_addr from datawindow within tabpage_address
end type
type tabpage_address from userobject within tab_emp
dw_addr dw_addr
end type
type tab_emp from tab within w_empl_dw_share_buffers
tabpage_employment tabpage_employment
tabpage_address tabpage_address
end type
type cb_close from commandbutton within w_empl_dw_share_buffers
end type
type cb_update from commandbutton within w_empl_dw_share_buffers
end type
type cb_retrieve from commandbutton within w_empl_dw_share_buffers
end type
type cb_next from commandbutton within w_empl_dw_share_buffers
end type
type cb_prior from commandbutton within w_empl_dw_share_buffers
end type
type dw_basic from datawindow within w_empl_dw_share_buffers
end type
end forward

global type w_empl_dw_share_buffers from w_center
integer x = 398
integer y = 48
integer width = 2135
integer height = 1768
string title = "Shared DataWindow Buffers"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
tab_emp tab_emp
cb_close cb_close
cb_update cb_update
cb_retrieve cb_retrieve
cb_next cb_next
cb_prior cb_prior
dw_basic dw_basic
end type
global w_empl_dw_share_buffers w_empl_dw_share_buffers

type variables
long   ii_row, ii_num_of_rows
int     ii_window_height
end variables

event open;call super::open;// Open script for w_empl_dw_share_buffers
integer li_ret

DataWindowChild	dwc

/****************************************************************
	Set Transaction Object ONLY for the primary DataWindow
 ***************************************************************/
dw_basic.SetTransObject (sqlca)

/****************************************************************
	Since the secondary DataWindows do not retrieve their
	DropDownDataWindows, do that now
 ***************************************************************/
tab_emp.tabpage_employment.dw_emp.GetChild ("dept_id", dwc)
dwc.SetTransObject (sqlca)
dwc.Retrieve ()

tab_emp.tabpage_address.dw_addr.GetChild ("state", dwc)
dwc.SetTransObject (sqlca)
dwc.Retrieve ()

//  get original size of window
ii_window_height = this.height

// Share the optional datawindows
li_ret = dw_basic.ShareData (tab_emp.tabpage_address.dw_addr)
if li_ret <> 1 then messagebox("Sharedata error","Error Sharing to address DW",exclamation!)

li_ret = dw_basic.ShareData (tab_emp.tabpage_employment.dw_emp)
if li_ret <> 1 then messagebox("Sharedata error","Error Sharing employment DW",exclamation!)

/****************************************************************
	Now, go retrieve data in the primary DataWindow
 ***************************************************************/
cb_retrieve.TriggerEvent (clicked!)

end event

on w_empl_dw_share_buffers.create
int iCurrent
call super::create
this.tab_emp=create tab_emp
this.cb_close=create cb_close
this.cb_update=create cb_update
this.cb_retrieve=create cb_retrieve
this.cb_next=create cb_next
this.cb_prior=create cb_prior
this.dw_basic=create dw_basic
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_emp
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_update
this.Control[iCurrent+4]=this.cb_retrieve
this.Control[iCurrent+5]=this.cb_next
this.Control[iCurrent+6]=this.cb_prior
this.Control[iCurrent+7]=this.dw_basic
end on

on w_empl_dw_share_buffers.destroy
call super::destroy
destroy(this.tab_emp)
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.cb_retrieve)
destroy(this.cb_next)
destroy(this.cb_prior)
destroy(this.dw_basic)
end on

event close;call super::close;// Close script for w_empl_dw_share_buffers
//w_main.Show ()

close(this)
end event

type tab_emp from tab within w_empl_dw_share_buffers
event create ( )
event destroy ( )
integer x = 55
integer y = 528
integer width = 2007
integer height = 1092
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 74481808
boolean raggedright = true
boolean showpicture = false
integer selectedtab = 1
tabpage_employment tabpage_employment
tabpage_address tabpage_address
end type

on tab_emp.create
this.tabpage_employment=create tabpage_employment
this.tabpage_address=create tabpage_address
this.Control[]={this.tabpage_employment,&
this.tabpage_address}
end on

on tab_emp.destroy
destroy(this.tabpage_employment)
destroy(this.tabpage_address)
end on

type tabpage_employment from userobject within tab_emp
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 1970
integer height = 976
long backcolor = 74481808
string text = "Employment"
long tabtextcolor = 41943040
long tabbackcolor = 74481808
long picturemaskcolor = 536870912
dw_emp dw_emp
end type

on tabpage_employment.create
this.dw_emp=create dw_emp
this.Control[]={this.dw_emp}
end on

on tabpage_employment.destroy
destroy(this.dw_emp)
end on

type dw_emp from datawindow within tabpage_employment
integer y = 56
integer width = 1925
integer height = 936
integer taborder = 41
string dataobject = "d_empl_employment_data"
boolean border = false
boolean livescroll = true
end type

type tabpage_address from userobject within tab_emp
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 1970
integer height = 976
long backcolor = 74481808
string text = "Address"
long tabtextcolor = 41943040
long tabbackcolor = 74481808
long picturemaskcolor = 536870912
dw_addr dw_addr
end type

on tabpage_address.create
this.dw_addr=create dw_addr
this.Control[]={this.dw_addr}
end on

on tabpage_address.destroy
destroy(this.dw_addr)
end on

type dw_addr from datawindow within tabpage_address
integer x = 9
integer y = 48
integer width = 1929
integer height = 472
integer taborder = 60
string dataobject = "d_empl_address_data"
boolean border = false
boolean livescroll = true
end type

type cb_close from commandbutton within w_empl_dw_share_buffers
integer x = 1577
integer y = 388
integer width = 489
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;// Clicked script for cb_close

Close (Parent)

end event

type cb_update from commandbutton within w_empl_dw_share_buffers
integer x = 1577
integer y = 284
integer width = 489
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Update"
end type

event clicked;// Clicked script for cb_update
int	li_rtn

li_rtn = dw_basic.Update ()

//check condition status of the update
//commit if ok .. Using Settransobject...
If li_rtn = 1 then
	COMMIT using SQLCA ;
else
	ROLLBACK using SQLCA ;
end if 

end event

type cb_retrieve from commandbutton within w_empl_dw_share_buffers
integer x = 1577
integer y = 184
integer width = 489
integer height = 88
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Retrieve"
end type

event clicked;// Clicked script for CB_RETRIEVE
//reload primary datawindow
ii_num_of_rows = dw_basic.Retrieve ()
ii_row = 1

end event

type cb_next from commandbutton within w_empl_dw_share_buffers
integer x = 1723
integer y = 60
integer width = 338
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Next"
end type

event clicked;// Clicked script for CB_NEXT
// scroll all datawindows to next row
If ii_row < ii_num_of_rows Then
	ii_row = ii_row + 1
	dw_basic.ScrollToRow (ii_row)
	tab_emp.tabpage_address.dw_addr.ScrollToRow (ii_row)
	tab_emp.tabpage_employment.dw_emp.ScrollToRow (ii_row)
Else
	Beep (1)
End If


end event

type cb_prior from commandbutton within w_empl_dw_share_buffers
integer x = 1362
integer y = 60
integer width = 338
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Prior"
end type

event clicked;// Clicked script for cb_prior
// scroll all datawindows to prior row
If ii_row > 1 Then
	ii_row = ii_row - 1
	dw_basic.ScrollToRow (ii_row)
	tab_emp.tabpage_address.dw_addr.ScrollToRow (ii_row)
	tab_emp.tabpage_employment.dw_emp.ScrollToRow (ii_row)
Else
	Beep (1)
End If

end event

type dw_basic from datawindow within w_empl_dw_share_buffers
integer x = 55
integer y = 12
integer width = 1271
integer height = 516
integer taborder = 10
string dataobject = "d_empl_basic_data"
boolean border = false
boolean livescroll = true
end type

