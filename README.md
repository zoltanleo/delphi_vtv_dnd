# delphi_vtv_dnd

VTV Manipulation Project

#### 1.0.20
- fix some bugs
- implemented delete action from table price

#### 1.0.19
- implemented tree modification and saving of results

#### 1.0.18
- all virtual tree events are set in the code at runtime

#### 1.0.17
- allow dragging only those nodes that are not in the database
- implemented verification of added records for uniqueness in the tree and database

#### 1.0.16
- fix some bugs

#### 1.0.15
- added the IsPickedNode public property to distinguish the value selected from the list from the newly entered one

#### 1.0.14
- redundant functionality is limited (rejection of d'n'd)
- implemented a list of possible selection of items for parent and child nodes when filling in the tree

![](pict/vtv_dnd_14.gif)

#### 1.0.13
- it is prohibited to change the names of existing price list items
- added functionality for adding/editing price list

![](pict/vtv_dnd_13.gif)

#### 1.0.12
- own rendering of the VTV header implemented on HeaderDraw event instead of AdvancedHeaderDraw event
- implemented showing/hiding "deleted" nodes

![](pict/vtv_dnd_12.gif)

#### 1.0.11
- implemented own rendering of the VTV header
![](pict/vtv_dnd_11.gif)

#### 1.0.10
- implemented node highlighting with updated prices
![](pict/vtv_dnd_10.gif)

#### 1.0.9
- implemented the ability to set the cost as zero
![](pict/vtv_dnd_09.gif) 

#### 1.0.8
- moved nodes now get the ParentID as the PriceID of the new root node.

#### 1.0.7
- fixed some bugs for addRoot/addChild/EditNode actions
- added new items for popup menu
![](pict/vtv_dnd_07.gif) 

#### 1.0.6
- added popupMenu + actions to expand/collapse nodes
![](pict/vtv_dnd_06.gif)

#### 1.0.5
- implemented all the main actions to update nodes

#### 1.0.4
- implemented actions to remove/restore a node
![](pict/vtv_dnd_04.gif)

#### 1.0.3
- implemented node editing actions
![](pict/vtv_dnd_03.gif)

#### 1.0.2
- added actions for node editing
- added checking the state of node editing buttons

![](pict/vtv_dnd_02.gif)

#### 1.0.1

- implemented mechanism  of d'n'd 

![](pict/vtv_dnd_01.gif)