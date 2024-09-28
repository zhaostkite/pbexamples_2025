﻿$PBExportHeader$w_entry_only.srw
$PBExportComments$A sales order entry window that allows rows to be inserted into the DataWindow but not modified.
forward
global type w_entry_only from w_center
end type
type st_windowback from statictext within w_entry_only
end type
type st_buttonface from statictext within w_entry_only
end type
type cb_delete from commandbutton within w_entry_only
end type
type cb_update from commandbutton within w_entry_only
end type
type cb_retrieve from commandbutton within w_entry_only
end type
type cb_insert from commandbutton within w_entry_only
end type
type cb_close from commandbutton within w_entry_only
end type
type dw_1 from datawindow within w_entry_only
end type
end forward

global type w_entry_only from w_center
integer x = 425
integer y = 412
integer width = 2647
integer height = 1664
string title = "Add-Only DataWindow"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
st_windowback st_windowback
st_buttonface st_buttonface
cb_delete cb_delete
cb_update cb_update
cb_retrieve cb_retrieve
cb_insert cb_insert
cb_close cb_close
dw_1 dw_1
end type
global w_entry_only w_entry_only

type variables
// Keeps track of the rows that cannot be deleted
long   il_perm_count
end variables

event open;call super::open;dw_1.SetTransObject (sqlca)

end event

event close;call super::close;//w_main.Show()
end event

on w_entry_only.create
int iCurrent
call super::create
this.st_windowback=create st_windowback
this.st_buttonface=create st_buttonface
this.cb_delete=create cb_delete
this.cb_update=create cb_update
this.cb_retrieve=create cb_retrieve
this.cb_insert=create cb_insert
this.cb_close=create cb_close
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_windowback
this.Control[iCurrent+2]=this.st_buttonface
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_update
this.Control[iCurrent+5]=this.cb_retrieve
this.Control[iCurrent+6]=this.cb_insert
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.dw_1
end on

on w_entry_only.destroy
call super::destroy
destroy(this.st_windowback)
destroy(this.st_buttonface)
destroy(this.cb_delete)
destroy(this.cb_update)
destroy(this.cb_retrieve)
destroy(this.cb_insert)
destroy(this.cb_close)
destroy(this.dw_1)
end on

type st_windowback from statictext within w_entry_only
boolean visible = false
integer x = 2162
integer y = 1164
integer width = 315
integer height = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean focusrectangle = false
end type

type st_buttonface from statictext within w_entry_only
boolean visible = false
integer x = 2162
integer y = 1008
integer width = 315
integer height = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 74481808
boolean enabled = false
boolean focusrectangle = false
end type

type cb_delete from commandbutton within w_entry_only
integer x = 2098
integer y = 436
integer width = 407
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Delete Row"
end type

on clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Delete the current row of the DataWindow
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_1.SetRedraw (false)
dw_1.DeleteRow (0)

// Disable the Delete Row button if there are no more new rows
if il_perm_count = dw_1.RowCount() then
	cb_delete.enabled = false
else
	dw_1.SetColumn (1)
	dw_1.SetFocus()
end if

dw_1.SetRedraw (true)
end on

type cb_update from commandbutton within w_entry_only
integer x = 2098
integer y = 592
integer width = 407
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Update"
end type

on clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Update the DataWindow
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_1.SetRedraw (false)
if dw_1.Update() = -1 then
	rollback;
else
	commit;
end if
dw_1.SetRedraw (true)
end on

type cb_retrieve from commandbutton within w_entry_only
integer x = 2094
integer y = 124
integer width = 407
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Retrieve"
end type

on clicked;//dw_1.SetRedraw (false)
dw_1.Retrieve()
//dw_1.SetRedraw (true)
end on

type cb_insert from commandbutton within w_entry_only
integer x = 2103
integer y = 280
integer width = 407
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Add Row"
end type

on clicked;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Insert a new row into the DataWindow prior to the current row.
//
// The expression for the protect attribute for the DataWindow columns, set in the DataWindow
// painter, will evaluate whether the row is new.  If the row is new, the column will not be 
// protected.  If the row is not new, the column will be protected.  An expression for the background
// color attribute will similarly determine that the background is white for columns on new rows, 
// and light gray for columns on other rows.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
long	ll_new_row


cb_delete.enabled = true
cb_update.enabled = true


ll_new_row = dw_1.InsertRow(0)

dw_1.SetFocus()
dw_1.ScrollToRow(ll_new_row)
dw_1.SetColumn(1)

end on

type cb_close from commandbutton within w_entry_only
integer x = 2098
integer y = 748
integer width = 407
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
end type

on clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// close the window
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

close (parent)
end on

type dw_1 from datawindow within w_entry_only
integer x = 55
integer y = 60
integer width = 1943
integer height = 1424
integer taborder = 10
string dataobject = "d_sales_order_items"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on retrieveend;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Enable command buttons
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
il_perm_count = this.RowCount()

cb_delete.enabled = false
cb_insert.enabled = true
cb_retrieve.enabled = true
cb_update.enabled = false


end on

on retrievestart;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Disable command buttons
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
cb_delete.enabled = false
cb_insert.enabled = false
cb_retrieve.enabled = false
cb_update.enabled = false
end on

