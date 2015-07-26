simulate_animation = function(animation, root_id, data){
  if(data.length == 0){
    //process karma
    last_karma = karma.pop();
    if(last_karma == null) return;
    animation.edges.add({to: last_karma.parent_id, from: last_karma.node_id, label: last_karma.return_value});
    animation.network.selectNodes([last_karma.parent_id], false);
    animation.network.focus(last_karma.parent_id, { animation: true});
    setTimeout(function(){simulate_animation(animation, last_karma.parent_id, last_karma.siblings)}, 1000);
  }
  else {
    node = data.splice(0, 1);
    node = node[0];
    animation.nodes.add({id: node.id, label: [node.class_name, node.method_name].join("::")});
    animation.edges.add({to: node.id, from: root_id, label: JSON.stringify(node.params)});
    animation.network.selectNodes([node.id], false);
    animation.network.focus(node.id, { animation: true});

    setTimeout(function(){
      karma.push({
        parent_id: root_id,
        node_id: node.id,
        return_value: JSON.stringify(node.return_value),
        siblings: data
      });
      simulate_animation(animation, node.id, node.calls);
    }, 1000);
  }
};

init_animation = function(container){
  nodes = new vis.DataSet();
  edges = new vis.DataSet();

  // create a network
  var data = {
      nodes: nodes,
      edges: edges
  };
  var options = {
    autoResize: true,
    layout: {
      hierarchical: {
        enabled: true,
        levelSeparation: 200,
        direction: 'UD',   // UD, DU, LR, RL
        sortMethod: 'directed'
      }
    },
    edges: {
      //physics: false,
      arrows: 'to',
      smooth: {
        enabled: true,
        type: 'curvedCW',
        roundness: 0.3,
      }
    },
    interaction: {
      dragNodes: false
    },
    nodes: {
      scaling: {
        min: 10,
        max: 30
      },
      shadow: true,
      shape: 'ellipse',
      color: {
        highlight: "#f15c2c"
      }
    },
    physics : {
      repulsion: {
        centralGravity: 0.5,
        springLength: 200,
        springConstant: 0.05,
        nodeDistance: 200,
        damping: 0.09
      }
    }
  };
  data.network = new vis.Network(container, data, options);
  return data;
}
