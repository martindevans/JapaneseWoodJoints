demo();

module demo() {
    stepped_dovetail_splice_female([12, 20, 10]);

    translate([0, 20, sin($t * 360) * -5 - 5])
    stepped_dovetail_splice_male([12, 20, 10]);
}

//Create the female half of a stepped dovetail splice
// size - A vector3 defining the size
// jpct - Joint Percentage (amount of y axis space which is joint)
// opct - Outer percentage (width of the outer part of the splice)
// ipct - Inner percentage (width of the inner part of the splice, must be > opct)
// dpct - Depth Percentage (depth of joint)
// spct - Step percentage (height of the step part)
module stepped_dovetail_splice_female(size, jpct = 0.9, opct = 0.3, ipct = 0.5, dpct = 0.4, spct = 0.5) {

    function x(t) = lookup(t, [[0, 0], [1, size[0]]]);
    function y(t) = lookup(t, [[0, 0], [1, size[1]]]);
    
    color([0.8, 0.3, 0.2])
    translate([0, 0, size[2] * (1 - spct)])
        cube([x(1), y(1), size[2] * spct]);
    
    color([0.8, 0.2, 0.2])
    linear_extrude(height = size[2] * (1 - spct))
        polygon([
            [x(0), y(0)],
            [x(0), y(jpct)],

            [x((1 - opct) / 2), y(jpct)],
    
            [x((1 - ipct) / 2), y(1 - dpct)],
            [x(1 - ((1 - ipct) / 2)), y(1 - dpct)],
            
            [x(1 - ((1 - opct) / 2)), y(jpct)],
    
            [x(1), y(jpct)],
            [x(1), y(0)],
        ]);

}

//Create the male half of a stepped dovetail splice
// Use the same parameters as the female half to create a matching male
module stepped_dovetail_splice_male(size, jpct = 0.9, opct = 0.3, ipct = 0.5, dpct = 0.4, spct = 0.5) {
    
    function x(t) = lookup(t, [[-1, -size[0]], [0, 0], [1, size[0]]]);
    function y(t) = lookup(t, [[-1, -size[1]], [0, 0], [1, size[1]]]);
    
    color([0.8, 0.3, 0.2])
    translate([x(0), y(0), size[2] * (1 - spct)])
        cube([x(1), y(1), size[2] * spct]);
    
    color([0.8, 0.2, 0.2])
    linear_extrude(height = size[2] * (1 - spct))
        polygon([
            [x(0), y(1)],
            [x(0), y(jpct - 1)],
            
            [x((1 - opct) / 2), y(jpct - 1)],
    
            [x((1 - ipct) / 2), y(-dpct)],
            [x(1 - ((1 - ipct) / 2)), y(-dpct)],
    
            [x(1 - ((1 - opct) / 2)), y(jpct - 1)],
    
            [x(1), y(jpct - 1)],
            [x(1), y(1)],
        ]);
}