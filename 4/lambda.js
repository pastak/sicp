// define square 
function square(x){return (x*x)};
// rewrite Scheme lambda with Javascript anonymous function
function f(x,y){
    (function(a, b){
        return ( x*(square(a)) + y*b + a*b );
    })( (1+x*y), (1-y) )
}
//呼び出し例 x=3,y=4
f(3,4)
