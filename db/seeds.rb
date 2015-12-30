# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

project = Project.create(
	project_name: "ECO Mod2")

product = Product.create(
	product_name: "ECO Mod2 Black",
	item_number: "VECO434QRBM2",
	status: "In prodcution")

task = Task.create(
	task: "Upload package design",
	executor: "Alan Tian")