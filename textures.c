
#include <stdio.h>
#include <GL/freeglut.h>
#include <GL/freeglut_ext.h>
#include <GL/freeglut_std.h>
#include <GL/glut.h>
#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

GLUquadricObj *sphere = NULL;

// code for loading an image from https://learnopengl.com/Getting-started/Textures
// also uses stb_image.h
unsigned int texture1;
unsigned int texture2;
unsigned int texture3;
unsigned int texture4;
unsigned int texture5;
int width, height, nrChannels, width2, height2, nrChannels2, width3, height3, nrChannels3, width4, height4, nrChannels4, width5, height5, nrChannels5;

void drawPumpkin()
{
    glPushMatrix();
    glRotatef(90, 1, 0, 0);
    glBindTexture(GL_TEXTURE_2D, texture1);
    gluSphere(sphere, 1.0, 50, 50);
    glPopMatrix();
}

void init()
{
    glClearColor(0.0, 0.0, 0.0, 1.0);
    glClearDepth(1.0);
    glEnable(GL_DEPTH_TEST);
    glDepthFunc(GL_LESS);
    glHint(GL_POLYGON_SMOOTH_HINT, GL_NICEST);
    glEnable(GL_LIGHTING);
    glEnable(GL_TEXTURE_2D);
    glShadeModel(GL_SMOOTH);
}

void display()
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glMatrixMode(GL_TEXTURE);
    glLoadIdentity();

    sphere = gluNewQuadric();
    gluQuadricDrawStyle(sphere, GLU_FILL);
    gluQuadricTexture(sphere, GL_TRUE);
    gluQuadricNormals(sphere, GLU_SMOOTH);

    glGenTextures(1, &texture1);
    glBindTexture(GL_TEXTURE_2D, texture1);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    unsigned char *data1 = stbi_load("Seamless_Pumpkin.png", &width, &height, &nrChannels, 0);
    if (data1)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, data1);
    else
        printf("Failed to load texture.");

    glGenTextures(1, &texture2);
    glBindTexture(GL_TEXTURE_2D, texture2);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    unsigned char *data2 = stbi_load("grass.jpeg", &width2, &height2, &nrChannels2, 0);
    if (data2)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width2, height2, 0, GL_RGB, GL_UNSIGNED_BYTE, data2);
    else
        printf("Failed to load texture.");

    glGenTextures(1, &texture3);
    glBindTexture(GL_TEXTURE_2D, texture3);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    unsigned char *data3 = stbi_load("stem.jpeg", &width3, &height3, &nrChannels3, 0);
    if (data3)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width3, height3, 0, GL_RGB, GL_UNSIGNED_BYTE, data3);
    else
        printf("Failed to load texture.");

    glGenTextures(1, &texture4);
    glBindTexture(GL_TEXTURE_2D, texture4);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    unsigned char *data4 = stbi_load("seamless_brick.jpeg", &width4, &height4, &nrChannels4, 0);
    if (data4)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width4, height4, 0, GL_RGB, GL_UNSIGNED_BYTE, data4);
    else
        printf("Failed to load texture.");

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();

    GLfloat light0_pos[] = { 0.0, 2.0, 3.0 };
    GLfloat light0_amb[4] = { 0.5294, 0.5333, 0.6118, 1.0 };
    glLightfv(GL_LIGHT0, GL_POSITION, light0_pos);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, light0_amb);
    glEnable(GL_LIGHT0);

    GLfloat light1_pos[4] = { 5.0, 7.0, 2.0, 1.0 };
    GLfloat light1_dif[4] = { 0.3294, 0.4196, 0.6706, 1.0};
    glLightfv(GL_LIGHT1, GL_POSITION, light1_pos);
    glLightfv(GL_LIGHT1, GL_DIFFUSE, light1_dif);
    glEnable(GL_LIGHT1);

    gluLookAt(0, 0, 4, 0, 0, 0, 0, 1, 0);       

    GLfloat const white[4] = { 1.0, 1.0, 1.0, 1.0 };

    // background
    glNormal3f(0.0, 0.0, 1.0);
    glBindTexture(GL_TEXTURE_2D, texture4);
    glBegin(GL_POLYGON);
    {
        glTexCoord2f(0, 0);
        glVertex3f(-20.0, -1.0, -10.0);
        glTexCoord2f(2.5, 0);
        glVertex3f(20.0, -1.0, -10.0);
        glTexCoord2f(2.5, 2.5);
        glVertex3f(20.0, 19.0, -10.0);
        glTexCoord2f(0, 2.5);
        glVertex3f(-20.0, 19.0, -10.0);
    }
    glEnd();

    // ground
    glNormal3f(1.0, 0.0, 0.0);
    glBindTexture(GL_TEXTURE_2D, texture2);
    glBegin(GL_POLYGON);
    {
        glTexCoord2f(0, 0);
        glVertex3f(-20.0, -1.0, 10.0);
        glTexCoord2f(3, 0);
        glVertex3f(20.0, -1.0, 10.0);
        glTexCoord2f(3, 3);
        glVertex3f(20.0, -1.0, -10.0);
        glTexCoord2f(0, 3);
        glVertex3f(-20.0, -1.0, -10.0);
    }
    glEnd();
    stbi_image_free(data2);

    drawPumpkin();

    // stem
    glNormal3f(0.0, 0.0, 1.0);
    glBindTexture(GL_TEXTURE_2D, texture3);
    glBegin(GL_POLYGON);
    {
        glTexCoord2f(0, 0);
        glVertex3f(-0.05, 0.33, 2.6);
        glTexCoord2f(1, 0);
        glVertex3f(0.05, 0.33, 2.6);
        glTexCoord2f(1, 1);
        glVertex3f(0.04, 0.46, 2.6);
        glTexCoord2f(0, 1);
        glVertex3f(-0.04, 0.46, 2.6);
    }
    glEnd();
    stbi_image_free(data3);

    glPushMatrix();
    glScalef(.5, .5, .5);
    glTranslatef(2.0, -0.5, 2.0);
    drawPumpkin();
    glPopMatrix();

    glPushMatrix();
    glScalef(.3, .3, .3);
    glTranslatef(-2.75, -1.0, 5.0);
    drawPumpkin();
    glPopMatrix();
    stbi_image_free(data1);

    glutSwapBuffers();
}

void idle()
{
    glutPostRedisplay();
}

void keyboard(unsigned char k, int x, int y)
{
    if (k == 'q' || k == 'Q')
        exit(0);
}


void reshape(int w, int h)
{
    glViewport(0, 0, w, h);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(60, (GLfloat)w / (GLfloat)h, 1.0, 100.0); // used from http://www.swiftless.com/tutorials/opengl/reshape.html
    glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char* argv[])
{
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);
    glutInitWindowSize(800, 400);
    glutCreateWindow("Textures");
    init();
    glutDisplayFunc(display);
    glutReshapeFunc(reshape);
    glutIdleFunc(idle);
    glutKeyboardFunc(keyboard);
    glutMainLoop();

    return 0;
}

