import SpriteKit

/********************************/
/* This file was autogenerated! */
/********************************/

struct PhysicsBodies {

  enum Body { {% for body in bodies %}
    case {{body.name}}{% endfor %}
  }

  static func getBody(_ body: Body) -> SKPhysicsBody {
    switch body { {% for body in bodies %}
    case .{{body.name}}:{% for fixture in body.fixtures %}{% if forloop.first %}{% if fixture.isCircle %}
        let body = SKPhysicsBody(circleOfRadius: {{fixture.radius|floatformat:1}} * {{body.scale_factor}} ){%else%}
        let path = CGMutablePath(){% for point in fixture.hull %}
        {% if forloop.first %}path.move(to: CGPoint(x: ({{point.x}} - {{body.anchorPointAbs.x|floatformat:1}}) * {{body.scale_factor|floatformat:1}}, y: ({{point.y|floatformat:1}} - {{body.anchorPointAbs.y|floatformat:1}}) * {{body.scale_factor|floatformat:1}}) ){% endif %}{% if not forloop.first %}path.addLine(to: CGPoint(x: ({{point.x|floatformat:1}} - {{body.anchorPointAbs.x|floatformat:1}}) * {{body.scale_factor|floatformat:1}}, y: ({{point.y|floatformat:1}} - {{body.anchorPointAbs.y|floatformat:1}}) * {{body.scale_factor|floatformat:1}}) ){% endif %}{% endfor %}
        path.closeSubpath()
        let body = SKPhysicsBody(polygonFrom: path){% endif %}
        body.affectedByGravity = {% if body.affected_by_gravity %}true{% else %}false{% endif %}
        body.allowsRotation = {% if body.allows_rotation %}true{% else %}false{% endif %}
        body.isDynamic = {% if body.is_dynamic %}true{% else %}false{% endif %}
        body.friction = {{ body.friction|floatformat:1 }}
        body.linearDamping = {{ body.linear_damping|floatformat:3 }}
        body.angularDamping = {{ body.angular_damping|floatformat:3 }}
        body.restitution = {{ body.restitution|floatformat:3 }}
        return body{% endif %}{% endfor %}{% endfor %}
    }
  }
}
