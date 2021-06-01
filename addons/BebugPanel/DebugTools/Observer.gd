extends Tabs

var root: TreeItem

signal monitor(node, property)
signal ignore(node, property)
#signal reset()

onready var _tree := $VBoxContainer/Tree


func spawn_tree(observation_groups) -> void:
	root = _tree.create_item()
	_tree.set_hide_root(true)
	for group in observation_groups:
		add_group_to_tree(group)
	collapse_children(root)


#func reset_tree():
#	_tree.clear()
#	emit_signal("reset")
#	spawn_tree()


func add_group_to_tree(group_in: String) -> void:
	var group = get_tree().get_nodes_in_group(group_in)
	assert(group, group_in + " group doesn't exist")
	if len(group) == 1:
		add_item_to_tree(group.front(), root)
	else:
		add_array_to_tree(group_in, group)


func add_array_to_tree(name_in: String, group_in: Array) -> void:
	var child = _tree.create_item(root)
	child.set_text(0, name_in)
	for item in group_in:
		add_item_to_tree(item, child)


func add_item_to_tree(item, base) -> void:
	var child = _tree.create_item(base)
	child.set_text(0, item.name)
	item.connect("tree_exiting", self, "cleanup_node", [child])

	var script_variable = _tree.create_item(child)
	script_variable.set_text(0, "script variable")
	var general_property = _tree.create_item(child)
	general_property.set_text(0, "general property")

	for property in item.get_property_list():
		match property["usage"]:
			PROPERTY_USAGE_DEFAULT:
				create_tree_property(general_property, property["name"], item)
			PROPERTY_USAGE_SCRIPT_VARIABLE:
				create_tree_property(script_variable, property["name"], item)
			_:
				continue


func create_tree_property(property_branch: TreeItem, text: String, item) -> void:
	var sub_child = _tree.create_item(property_branch)
	sub_child.set_cell_mode(0, TreeItem.CELL_MODE_CHECK)
	sub_child.set_editable(0, true)
	sub_child.set_metadata(0, item)
	sub_child.set_text(0, text)


func cleanup_node(node):
	if node:
		node.free()


func collapse_children(root_in: TreeItem):
	var child = root_in.get_children()
	while child:
		collapse_children(child)
		child.collapsed = true
		child = child.get_next()


func _on_Tree_item_edited() -> void:
	var edit = _tree.get_edited()
	if edit.is_checked(0):
		emit_signal("monitor", edit.get_metadata(0), edit.get_text(0))
	else:
		emit_signal("ignore", edit.get_metadata(0), edit.get_text(0))
