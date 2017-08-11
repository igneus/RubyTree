#!/usr/bin/env ruby
#
# tree_spec.rb
#
# Author:  Anupam Sengupta
# Time-stamp: <2015-12-31 22:57:59 anupam>
# Copyright (C) 2015 Anupam Sengupta <anupamsg@gmail.com>
#

require "rspec"
require "spec_helper"

describe Tree do

  shared_examples_for "any detached node" do
    it 'should not equal "Object.new"' do
      expect(@tree).not_to eq(Object.new)
    end
    it 'should not equal 1 or any other fixnum' do
      expect(@tree).not_to eq(1)
    end
    it 'identifies itself as a root node' do
      expect(@tree.is_root?).to eq(true)
    end
    it "does not have a parent node" do
      expect(@tree.parent).to eq(nil)
    end

  end
  context "#initialize", "with empty name and nil content" do
    before(:each) do
      @tree = Tree::TreeNode.new("")
    end
    it 'creates the tree node with name as ""' do
      expect(@tree.name).to eq("")
    end
    it "has 'nil' content" do
      expect(@tree.content).to eq(nil)
    end

    it_behaves_like "any detached node"
  end

  context "#initialize", "with name 'A' and nil content" do
    before(:each) do
      @tree = Tree::TreeNode.new("A")
    end

    it 'creates the tree node with name as "A"' do
      expect(@tree.name).to eq("A")
    end
    it "has 'nil' content" do
      expect(@tree.content).to eq(nil)
    end

    it_behaves_like "any detached node"
  end

  context "#initialize", "with node name 'A' and some content" do
    before(:each) do
      @sample = "sample"
      @tree = Tree::TreeNode.new("A", @sample)
    end

    it 'creates the tree node with name as "A"' do
      expect(@tree.name).to eq("A")
    end
    it "has some content #{@sample}" do
      expect(@tree.content).to eq(@sample)
    end

    it_behaves_like "any detached node"
  end

  shared_examples_for "any cloned node" do
    it "is equal to the original" do
      expect(@clone).to eq @tree
    end
    it "is not identical to the original" do
      expect(clone).not_to be @tree
    end
  end

  context "#detached_copy", "without content" do
    before(:each) do
      @tree = Tree::TreeNode.new("A", nil)
      @clone = @tree.detached_copy
    end

    it_behaves_like "any cloned node"
  end

  context "#detached_copy", "with clonable content" do
    before(:each) do
      @tree = Tree::TreeNode.new("A", "clonable content")
      @clone = @tree.detached_copy
    end

    it "makes a clone of the content" do
      expect(@clone.content).to eq @tree.content
      expect(@clone.content).not_to be @tree.content
    end

    it_behaves_like "any cloned node"
  end

  context "#detached_copy", "with unclonable content" do
    before(:each) do
      @tree = Tree::TreeNode.new("A", :unclonable_content)
      @clone = @tree.detached_copy
    end

    it "keeps the content" do
      expect(@clone.content).to be @tree.content
    end

    it_behaves_like "any cloned node"
  end
end
