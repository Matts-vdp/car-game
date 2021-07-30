extends RigidBody2D
export var id = 0
export var speed = 450
export var torque = 400
export var drag = 1.0
export var fs = 4.5
export var fd = 0.45
export var driftspeedl = 75
export var driftspeedm = 170
var thrust = Vector2()
var rotation_dir
var drifting = false
var stopspeed = 10
var right = false
var left = false
var up = false
var down = false


# calculate new forces
func _physics_process(delta):
    set_applied_force(Vector2()) # reset the applied force
    
    #get forward and backward vector
    var v = Vector2(0,1).rotated(rotation) # creating forward facing vector
    var front= linear_velocity.project(v)
    if abs(front.angle_to(v)) > PI/2:
        front = front.length()
    else:
        front = -front.length()
    
    v = Vector2(0,1).rotated(rotation+PI/2) # creating sideways facing vector
    var side = linear_velocity.project(v)
    if abs(side.angle_to(v)) > PI/2:
        side = -side.length()
    else:
        side = side.length()
    v = Vector2(side, front)
    
    # see if the sideways speed is more then the driftlimit
    # if so start drifting
    # when onder the lower drift limit stop drifting
    var v3 = Vector2()
    if drifting:
        if side<driftspeedl && side>-driftspeedl:
            drifting = false
            $Particles2D.emitting = false
            $Particles2D2.emitting = false
        v3.x = side * fd
    else:
        if side>driftspeedm || side<-driftspeedm:
            drifting = true
            $Particles2D.emitting = true
            $Particles2D2.emitting = true
        v3.x = side * fs
    add_central_force(v3.rotated(rotation)) # counteract sideways speed

    #calculate drag
    var v2 = Vector2()
    v2 = linear_velocity * linear_velocity.length() * (drag/1000)
    add_central_force(-v2)
    
    #calculate acceleration
    thrust = Vector2()
    if Input.is_action_pressed('up%s' % id) || up:
        thrust = Vector2(0, -speed)
    elif Input.is_action_pressed('down%s' % id) || down:
        thrust = Vector2(0, speed)
    else:
        if linear_velocity.length()<stopspeed: # helps to stop completely
            linear_velocity = Vector2()
    thrust = thrust.rotated(rotation)
    add_central_force(thrust)
    

    #rotation
    rotation_dir = 0
    if Input.is_action_pressed('right%s' % id) || right:
        rotation_dir += 1
    if Input.is_action_pressed('left%s' % id) || left:
        rotation_dir -= 1
    if linear_velocity.length_squared() < 0: # rotate the other way when driving backwards
        rotation_dir *= -1
    set_applied_torque(rotation_dir*torque*sqrt(linear_velocity.length()))


func _on_Control_down(i):
    down = i


func _on_Control_left(i):
    left = i


func _on_Control_right(i):
    right = i


func _on_Control_up(i):
    up = i
